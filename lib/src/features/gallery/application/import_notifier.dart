import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import 'image_import_service.dart';

/// 批量导入流水线阶段枚举
enum ImportStage {
  /// 空闲待命
  idle,

  /// 正在唤起系统文件选择器
  picking,

  /// 正在按队列逐张处理导入
  importing,

  /// 批次导入完成
  completed,

  /// 用户主动取消
  cancelled,
}

/// 批量导入进度与统计快照
class ImportProgressState {
  /// 当前导入阶段
  final ImportStage stage;

  /// 本批次选中的文件总数
  final int totalCount;

  /// 当前已完成处理的序号（1-indexed）
  final int currentProcessed;

  /// 当前正在处理的文件名
  final String currentFileName;

  /// 成功入库数量
  final int successCount;

  /// 判定为重复而静默跳过的数量
  final int skippedCount;

  /// 处理失败的数量
  final int failedCount;

  /// 失败原因列表（收集用于导入后弹窗报告）
  final List<String> failureReasons;

  const ImportProgressState({
    required this.stage,
    required this.totalCount,
    required this.currentProcessed,
    required this.currentFileName,
    required this.successCount,
    required this.skippedCount,
    required this.failedCount,
    required this.failureReasons,
  });

  /// 初始空闲状态
  const ImportProgressState.idle()
      : stage = ImportStage.idle,
        totalCount = 0,
        currentProcessed = 0,
        currentFileName = '',
        successCount = 0,
        skippedCount = 0,
        failedCount = 0,
        failureReasons = const [];

  /// 当前百分比进度（0.0 ~ 1.0）
  double get progress =>
      totalCount == 0 ? 0.0 : (currentProcessed / totalCount).clamp(0.0, 1.0);

  bool get isIdle => stage == ImportStage.idle;
  bool get isPicking => stage == ImportStage.picking;
  bool get isImporting => stage == ImportStage.importing;
  bool get isCompleted => stage == ImportStage.completed;
  bool get isCancelled => stage == ImportStage.cancelled;
  bool get isRunning => isPicking || isImporting;

  /// 生成简洁的导入结果汇总文本
  String get summaryMessage {
    if (isCompleted) {
      return '导入完成：成功 $successCount 张，跳过重复 $skippedCount 张，失败 $failedCount 张';
    } else if (isCancelled) {
      return '导入已取消：已处理 $currentProcessed/$totalCount 张（成功 $successCount，跳过 $skippedCount）';
    }
    return '';
  }

  ImportProgressState copyWith({
    ImportStage? stage,
    int? totalCount,
    int? currentProcessed,
    String? currentFileName,
    int? successCount,
    int? skippedCount,
    int? failedCount,
    List<String>? failureReasons,
  }) {
    return ImportProgressState(
      stage: stage ?? this.stage,
      totalCount: totalCount ?? this.totalCount,
      currentProcessed: currentProcessed ?? this.currentProcessed,
      currentFileName: currentFileName ?? this.currentFileName,
      successCount: successCount ?? this.successCount,
      skippedCount: skippedCount ?? this.skippedCount,
      failedCount: failedCount ?? this.failedCount,
      failureReasons: failureReasons ?? this.failureReasons,
    );
  }
}

/// 批量图片导入状态管理与调度器
///
/// 核心职责：
/// 1. 唤起跨平台文件选取（支持单选与多选，过滤常见图片格式）；
/// 2. 维持单任务顺序流逐张推进，逐张向 UI 分发响应式进度（当前文件名、进度百分比、统计数）；
/// 3. 支持协作式优雅取消（不破坏当前正在写入的单张图片）；
/// 4. 汇总批量完成报告，提供无缝对接 UI 的响应式驱动模型。
class ImportNotifier extends Notifier<ImportProgressState> {
  bool _isCancelled = false;

  /// 支持导入的主流图片格式扩展名
  static const List<String> supportedExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp',
    'gif',
    'bmp',
    'tiff',
    'ico',
  ];

  @override
  ImportProgressState build() {
    return const ImportProgressState.idle();
  }

  /// 唤起系统文件选择器并直接启动导入流水线
  Future<void> pickAndImportFiles({BigInt? targetGroupId}) async {
    state = state.copyWith(stage: ImportStage.picking);

    try {
      final pickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: supportedExtensions,
      );

      if (pickerResult == null || pickerResult.files.isEmpty) {
        state = const ImportProgressState.idle();
        return;
      }

      final validPaths = pickerResult.paths
          .whereType<String>()
          .where((path) => path.isNotEmpty)
          .toList();

      if (validPaths.isEmpty) {
        state = const ImportProgressState.idle();
        return;
      }

      await importFiles(validPaths, targetGroupId: targetGroupId);
    } catch (e) {
      state = state.copyWith(
        stage: ImportStage.completed,
        failureReasons: [...state.failureReasons, '选取文件失败: $e'],
      );
    }
  }

  /// 顺序流式处理指定的文件路径列表
  Future<void> importFiles(
    List<String> filePaths, {
    BigInt? targetGroupId,
  }) async {
    _isCancelled = false;
    final total = filePaths.length;
    final service = ref.read(imageImportServiceProvider);

    state = ImportProgressState(
      stage: ImportStage.importing,
      totalCount: total,
      currentProcessed: 0,
      currentFileName: '',
      successCount: 0,
      skippedCount: 0,
      failedCount: 0,
      failureReasons: const [],
    );

    int success = 0;
    int skipped = 0;
    int failed = 0;
    final failures = <String>[];

    for (int i = 0; i < total; i++) {
      if (_isCancelled) {
        state = state.copyWith(stage: ImportStage.cancelled);
        return;
      }

      final currentPath = filePaths[i];
      final currentName = p.basename(currentPath);

      // 更新当前正在处理的文件状态
      state = state.copyWith(
        currentProcessed: i,
        currentFileName: currentName,
      );

      final result = await service.importFile(
        currentPath,
        targetGroupId: targetGroupId,
      );

      switch (result.status) {
        case ImportStatus.success:
          success++;
          break;
        case ImportStatus.skippedDuplicate:
          skipped++;
          break;
        case ImportStatus.failed:
          failed++;
          if (result.errorMessage != null) {
            failures.add('$currentName: ${result.errorMessage}');
          }
          break;
      }

      // 单图处理完毕，推进一步已完成数
      state = state.copyWith(
        currentProcessed: i + 1,
        successCount: success,
        skippedCount: skipped,
        failedCount: failed,
        failureReasons: failures,
      );
    }

    state = state.copyWith(
      stage: ImportStage.completed,
      currentFileName: '',
    );
  }

  /// 协作式请求取消后续导入
  void cancel() {
    _isCancelled = true;
  }

  /// 重置为初始空闲状态
  void reset() {
    _isCancelled = false;
    state = const ImportProgressState.idle();
  }
}

/// 全局 ImportNotifier 提供者
final importNotifierProvider =
    NotifierProvider<ImportNotifier, ImportProgressState>(ImportNotifier.new);
