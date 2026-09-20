import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/core/database/app_database.dart' as db;
import 'src/core/vault/vault_service.dart';
import 'src/features/gallery/application/import_notifier.dart';
import 'src/features/gallery/data/image_repository.dart';
import 'src/features/groups/data/group_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: LunovaApp()));
}

class LunovaApp extends StatelessWidget {
  const LunovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lunova 冒烟验证台',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const SmokeTestDashboardPage(),
    );
  }
}

/// 临时冒烟验证控制台（仅用于底层管道功能验证，非正式 UI）
class SmokeTestDashboardPage extends ConsumerStatefulWidget {
  const SmokeTestDashboardPage({super.key});

  @override
  ConsumerState<SmokeTestDashboardPage> createState() =>
      _SmokeTestDashboardPageState();
}

class _SmokeTestDashboardPageState
    extends ConsumerState<SmokeTestDashboardPage> {
  String _vaultPath = '正在获取...';
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _loadVaultInfo();
  }

  Future<void> _loadVaultInfo() async {
    final vaultService = ref.read(vaultServiceProvider);
    final path = await vaultService.getDefaultVaultPath();
    if (mounted) {
      setState(() {
        _vaultPath = path;
        _isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupRepo = ref.watch(groupRepositoryProvider);
    final imageRepo = ref.watch(imageRepositoryProvider);
    final vaultService = ref.watch(vaultServiceProvider);
    final importState = ref.watch(importNotifierProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lunova 冒烟验证桩 (临时测试用)'),
          elevation: 2,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.photo_library), text: 'M2 图片导入与缩略图流水线'),
              Tab(icon: Icon(Icons.folder), text: 'M1 分组数据层验证'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: M2 导入流水线测试
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 顶部控制与进度状态卡片
                  Card(
                    elevation: 0,
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              FilledButton.icon(
                                onPressed: importState.isRunning || !_isInit
                                    ? null
                                    : () => ref
                                        .read(importNotifierProvider.notifier)
                                        .pickAndImportFiles(),
                                icon: const Icon(Icons.add_photo_alternate),
                                label: const Text('选择图片导入 (支持单选/多选)'),
                              ),
                              const SizedBox(width: 12),
                              if (importState.isImporting)
                                OutlinedButton.icon(
                                  onPressed: () => ref
                                      .read(importNotifierProvider.notifier)
                                      .cancel(),
                                  icon: const Icon(Icons.stop),
                                  label: const Text('取消导入'),
                                ),
                              if (importState.isCompleted ||
                                  importState.isCancelled)
                                TextButton.icon(
                                  onPressed: () => ref
                                      .read(importNotifierProvider.notifier)
                                      .reset(),
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('重置状态'),
                                ),
                            ],
                          ),
                          if (importState.isPicking) ...[
                            const SizedBox(height: 12),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                ),
                                SizedBox(width: 8),
                                Text('正在等待用户选取文件...'),
                              ],
                            ),
                          ],
                          if (importState.isImporting) ...[
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                                value: importState.progress),
                            const SizedBox(height: 8),
                            Text(
                              '处理进度: ${importState.currentProcessed}/${importState.totalCount} - ${importState.currentFileName}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                          if (importState.summaryMessage.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: importState.failedCount > 0
                                    ? Colors.amber.shade100
                                    : Colors.green.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                importState.summaryMessage,
                                style: TextStyle(
                                  color: importState.failedCount > 0
                                      ? Colors.brown.shade900
                                      : Colors.green.shade900,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '已入库图片流 (纯读缩略图 .thumbnails/*.webp)',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: StreamBuilder<List<db.Image>>(
                      stream: imageRepo.watchImages(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text('读取异常: ${snapshot.error}'));
                        }

                        final images = snapshot.data ?? [];
                        if (images.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.photo_library_outlined,
                                    size: 64, color: Colors.grey.shade400),
                                const SizedBox(height: 8),
                                const Text(
                                    '暂无图片，点击上方按钮选择单张或批量图片导入'),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          itemCount: images.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final item = images[index];
                            final thumbPath = vaultService.getThumbnailsPath(
                                _vaultPath, item.sha256);
                            final thumbFile = File(thumbPath);

                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: SizedBox(
                                  width: 52,
                                  height: 52,
                                  child: Image.file(
                                    thumbFile,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.broken_image,
                                          size: 24),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                '${item.title} (${item.extension.toUpperCase()})',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                '尺寸: ${item.width}x${item.height} | 大小: ${(item.fileSize.toInt() / 1024).toStringAsFixed(1)} KB\n'
                                '哈希: ${item.sha256.substring(0, 12)}... | 相对路径: ${item.relativePath}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              isThreeLine: true,
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                tooltip: '彻底物理删除记录',
                                onPressed: () =>
                                    imageRepo.permanentlyDelete(item.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Tab 2: M1 分组测试
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Groups 表数据',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      FilledButton.icon(
                        onPressed: !_isInit
                            ? null
                            : () async {
                                final now = DateTime.now();
                                await groupRepo.createGroup(
                                  db.GroupsCompanion.insert(
                                    name:
                                        '测试分组 ${now.hour}:${now.minute}:${now.second}',
                                    icon: const Value('folder'),
                                    sortOrder: const Value(0),
                                  ),
                                );
                              },
                        icon: const Icon(Icons.add),
                        label: const Text('写入测试分组'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: StreamBuilder<List<db.Group>>(
                      stream: groupRepo.watchAllGroups(),
                      builder: (context, snapshot) {
                        final groups = snapshot.data ?? [];
                        if (groups.isEmpty) {
                          return const Center(child: Text('分组列表为空'));
                        }
                        return ListView.separated(
                          itemCount: groups.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final g = groups[index];
                            return ListTile(
                              leading: const CircleAvatar(
                                  child: Icon(Icons.folder)),
                              title: Text(g.name),
                              subtitle: Text(
                                  'ID: ${g.id} | 创建时间: ${g.createdAt.toLocal()}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                onPressed: () => groupRepo.deleteGroup(g.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
