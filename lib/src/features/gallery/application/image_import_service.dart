import 'dart:io';
import 'package:crypto/crypto.dart' as crypto;
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

import '../../../core/database/app_database.dart';
import '../../../core/vault/vault_service.dart';
import '../data/image_repository.dart';
import 'thumbnail_processor.dart';

/// 单个图片导入的状态枚举
enum ImportStatus {
  /// 导入成功并成功入库
  success,

  /// 指纹已存在，判定为重复图片并静默跳过
  skippedDuplicate,

  /// 处理失败（如文件损坏、格式不支持、I/O 异常等）
  failed,
}

/// 单张图片导入流水线的处理结果实体
class ImportSingleResult {
  final ImportStatus status;
  final String sourcePath;
  final Image? image;
  final String? errorMessage;

  const ImportSingleResult.success({
    required this.sourcePath,
    required this.image,
  })  : status = ImportStatus.success,
        errorMessage = null;

  const ImportSingleResult.skippedDuplicate({
    required this.sourcePath,
    required this.image,
  })  : status = ImportStatus.skippedDuplicate,
        errorMessage = null;

  const ImportSingleResult.failed({
    required this.sourcePath,
    required this.errorMessage,
  })  : status = ImportStatus.failed,
        image = null;

  bool get isSuccess => status == ImportStatus.success;
  bool get isSkipped => status == ImportStatus.skippedDuplicate;
  bool get isFailed => status == ImportStatus.failed;
}

/// 图片资产导入领域核心服务
///
/// 核心职责：串联完整的单图导入事务流水线：
/// 1. 源文件存在性校验与流式 SHA-256 哈希计算（规避大文件瞬时堆内存膨胀）；
/// 2. 数据库快速查重（若 SHA-256 已存在则静默标记跳过，杜绝冗余落盘与写入）；
/// 3. 原图安全归档至资料库（按年月 `originals/YYYY/MM/<hash>.<ext>` 存储）；
/// 4. 异步调用后台 Isolate 生成 400px WebP 缩略图并同步提取图片真实像素宽高；
/// 5. 写入 Drift SQLite 数据库并返回持久化实体；
/// 6. 物理自洁回滚（若缩略图生成或写库失败，自动物理删除刚复制的原图与缩略图，杜绝脏文件残留）。
class ImageImportService {
  ImageImportService({
    required this.vaultService,
    required this.imageRepository,
    required this.thumbnailProcessor,
  });

  final VaultService vaultService;
  final ImageRepository imageRepository;
  final ThumbnailProcessor thumbnailProcessor;

  /// 执行单张图片文件的完整导入流水线
  Future<ImportSingleResult> importFile(
    String sourceFilePath, {
    BigInt? targetGroupId,
  }) async {
    final sourceFile = File(sourceFilePath);
    if (!await sourceFile.exists()) {
      return ImportSingleResult.failed(
        sourcePath: sourceFilePath,
        errorMessage: '源文件不存在: $sourceFilePath',
      );
    }

    // 1. 流式计算 SHA-256 哈希（分块读取，内存极其安全）
    final String fileHash;
    try {
      final digest = await crypto.sha256.bind(sourceFile.openRead()).first;
      fileHash = digest.toString();
    } catch (e) {
      return ImportSingleResult.failed(
        sourcePath: sourceFilePath,
        errorMessage: '计算文件哈希失败: $e',
      );
    }

    // 2. 查重排重（SHA-256 已入库即认定为已收录）
    try {
      final existing = await imageRepository.findBySha256(fileHash);
      if (existing != null) {
        return ImportSingleResult.skippedDuplicate(
          sourcePath: sourceFilePath,
          image: existing,
        );
      }
    } catch (e) {
      return ImportSingleResult.failed(
        sourcePath: sourceFilePath,
        errorMessage: '查询现有图片哈希失败: $e',
      );
    }

    // 3. 准备基础元数据与文件系统目标路径
    final fileName = p.basename(sourceFilePath);
    final title = p.basenameWithoutExtension(sourceFilePath);
    final rawExt = p.extension(sourceFilePath).toLowerCase();
    final ext = rawExt.startsWith('.') ? rawExt.substring(1) : rawExt;
    final now = DateTime.now();

    final vaultPath = await vaultService.getDefaultVaultPath();
    // 资料库内部原图命名：`originals/YYYY/MM/<hash>.<ext>`（防重名冲突且直观有序）
    final internalFileName = ext.isNotEmpty ? '$fileHash.$ext' : fileHash;
    final targetOriginalPath = vaultService.getOriginalsPath(
      vaultPath,
      now,
      internalFileName,
    );
    final targetThumbnailPath = vaultService.getThumbnailsPath(
      vaultPath,
      fileHash,
    );

    // 跨平台统一正斜杠相对路径（如 originals/2026/09/xxxx.png），便携版移动盘符不失效
    final relativePath = p
        .split(p.relative(targetOriginalPath, from: vaultPath))
        .join('/');

    File? copiedOriginalFile;
    File? generatedThumbnailFile;

    try {
      // 4. 读取物理属性与 MIME 类型（结合后缀与前 128 字节魔数判定）
      final fileSize = await sourceFile.length();
      final fileModifiedAt = await sourceFile.lastModified();

      List<int>? headerBytes;
      try {
        final raf = await sourceFile.open(mode: FileMode.read);
        headerBytes = await raf.read(128);
        await raf.close();
      } catch (_) {}

      final mimeType =
          lookupMimeType(sourceFilePath, headerBytes: headerBytes) ??
          'image/jpeg';

      // 5. 复制原图到资料库归档位置
      copiedOriginalFile = File(targetOriginalPath);
      if (!await copiedOriginalFile.parent.exists()) {
        await copiedOriginalFile.parent.create(recursive: true);
      }
      await sourceFile.copy(targetOriginalPath);

      // 6. 后台 Isolate 生成 400px WebP 缩略图并提取真实像素宽高
      final thumbResult = await thumbnailProcessor.process(
        inputPath: targetOriginalPath,
        outputPath: targetThumbnailPath,
        maxLongEdge: 400,
        quality: 80,
      );
      generatedThumbnailFile = File(thumbResult.thumbnailPath);

      // 7. 写入 Drift 数据库
      final companion = ImagesCompanion.insert(
        sha256: fileHash,
        fileName: fileName,
        relativePath: relativePath,
        fileSize: BigInt.from(fileSize),
        extension: ext,
        mimeType: Value(mimeType),
        width: Value(thumbResult.width),
        height: Value(thumbResult.height),
        aspectRatio: Value(thumbResult.aspectRatio),
        title: title,
        groupId: Value(targetGroupId),
        isFavorite: const Value(false),
        isDeleted: const Value(false),
        importedAt: Value(now),
        fileModifiedAt: Value(fileModifiedAt),
      );

      final insertedImage = await imageRepository.insertImage(companion);

      return ImportSingleResult.success(
        sourcePath: sourceFilePath,
        image: insertedImage,
      );
    } catch (e) {
      // 事务级清理保障：若后续步骤（如缩略图或数据库写入）抛错，彻底清理刚复制落盘的文件
      if (copiedOriginalFile != null && await copiedOriginalFile.exists()) {
        try {
          await copiedOriginalFile.delete();
        } catch (_) {}
      }
      if (generatedThumbnailFile != null &&
          await generatedThumbnailFile.exists()) {
        try {
          await generatedThumbnailFile.delete();
        } catch (_) {}
      }

      return ImportSingleResult.failed(
        sourcePath: sourceFilePath,
        errorMessage: '导入过程出现异常: $e',
      );
    }
  }
}

/// ImageImportService 的全局只读 Riverpod Provider
final imageImportServiceProvider = Provider<ImageImportService>((ref) {
  final vaultService = ref.watch(vaultServiceProvider);
  final imageRepo = ref.watch(imageRepositoryProvider);
  final thumbnailProcessor = ref.watch(thumbnailProcessorProvider);

  return ImageImportService(
    vaultService: vaultService,
    imageRepository: imageRepo,
    thumbnailProcessor: thumbnailProcessor,
  );
});
