import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/core/database/app_database.dart';
import 'src/core/vault/vault_service.dart';
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
      title: 'Lunova 图片管理',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const M1VerificationPage(),
    );
  }
}

/// M1 阶段基础设施与数据层验证页
class M1VerificationPage extends ConsumerStatefulWidget {
  const M1VerificationPage({super.key});

  @override
  ConsumerState<M1VerificationPage> createState() => _M1VerificationPageState();
}

class _M1VerificationPageState extends ConsumerState<M1VerificationPage> {
  String _vaultPath = '正在获取...';
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _loadVaultInfo();
  }

  Future<void> _loadVaultInfo() async {
    final vaultService = VaultService();
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lunova 基础设施验证 (M1)'),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '资料库物理存储状态',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('资料库根路径: $_vaultPath'),
                    const SizedBox(height: 4),
                    const Text(
                      '便携模式: 已启用 (Windows Debug 模式自动隔离至工程内 dev_vault)',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '数据库 Groups 表响应式流 (Stream)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                FilledButton.icon(
                  onPressed: !_isInit
                      ? null
                      : () async {
                          final now = DateTime.now();
                          await groupRepo.createGroup(
                            GroupsCompanion.insert(
                              name: '素材分组 ${now.hour}:${now.minute}:${now.second}',
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
              child: StreamBuilder(
                stream: groupRepo.watchAllGroups(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('读取异常: ${snapshot.error}'));
                  }

                  final groups = snapshot.data ?? [];
                  if (groups.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.folder_open, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 8),
                          const Text('当前数据库为空，点击右上角按钮写入测试数据'),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: groups.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),

                    itemBuilder: (context, index) {
                      final g = groups[index];
                      return ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.folder)),
                        title: Text(g.name),
                        subtitle: Text('ID: ${g.id} | 创建时间: ${g.createdAt.toLocal()}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
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
    );
  }
}
