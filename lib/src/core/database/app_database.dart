import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../vault/vault_service.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Lunova 全局 SQLite 数据库引擎
/// 负责纳管 Groups、Images、Tags、ImageTags 四张核心表
@DriftDatabase(tables: [Groups, Images, Tags, ImageTags])
class AppDatabase extends _$AppDatabase {
  /// 默认使用 Vault 物理数据库连接，同时也支持注入内存数据库（用于后续单元测试）
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  /// 开启 SQLite 连接
  /// 1. 动态获取当前 Vault 路径 (Windows 绿色便携目录 / Android 专属沙盒)
  /// 2. 自动检查并初始化 .thumbnails 与 originals 目录结构
  /// 3. 返回 lunova.db 的物理路径
  /// 4. 开启 shareAcrossIsolates，允许后台 Isolate（如缩略图计算、网络传输）共享访问
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'lunova',
      native: DriftNativeOptions(
        databasePath: () async {
          final vaultService = VaultService();
          final vaultPath = await vaultService.getDefaultVaultPath();
          await vaultService.initializeVault(vaultPath);
          return vaultService.getDbPath(vaultPath);
        },
        shareAcrossIsolates: true,
      ),
    );
  }
}
