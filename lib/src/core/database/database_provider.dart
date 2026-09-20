import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// 全局数据库实例提供者
///
/// 生命周期与应用一致，当 Provider 容器销毁时自动调用 `db.close()` 释放 SQLite 连接与文件锁。
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
