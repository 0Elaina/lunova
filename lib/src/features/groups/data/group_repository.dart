import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

/// 分组仓储
///
/// 封装对 Groups 表的树形层级管理与 CRUD 操作。
class GroupRepository {
  GroupRepository(this._db);

  final AppDatabase _db;

  /// 创建新分组
  Future<Group> createGroup(GroupsCompanion companion) {
    return _db.into(_db.groups).insertReturning(companion);
  }

  /// 响应式监听所有分组 (按排序权重 sortOrder 升序排列)
  Stream<List<Group>> watchAllGroups() {
    return (_db.select(_db.groups)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.sortOrder, mode: OrderingMode.asc),
            (tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  /// 监听根级顶层分组 (parentId 为 null)
  Stream<List<Group>> watchRootGroups() {
    return (_db.select(_db.groups)
          ..where((tbl) => tbl.parentId.isNull())
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.sortOrder, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  /// 监听指定父分组下的直接子分组
  Stream<List<Group>> watchSubGroups(BigInt parentId) {
    return (_db.select(_db.groups)
          ..where((tbl) => tbl.parentId.equals(parentId))
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.sortOrder, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  /// 重命名分组
  Future<bool> renameGroup(BigInt id, String newName) async {
    final count = await (_db.update(_db.groups)
          ..where((tbl) => tbl.id.equals(id)))
        .write(GroupsCompanion(
      name: Value(newName),
      updatedAt: Value(DateTime.now()),
    ));
    return count > 0;
  }

  /// 设置或清除分组封面图片
  Future<bool> updateCover(BigInt id, BigInt? coverImageId) async {
    final count = await (_db.update(_db.groups)
          ..where((tbl) => tbl.id.equals(id)))
        .write(GroupsCompanion(
      coverImageId: Value(coverImageId),
      updatedAt: Value(DateTime.now()),
    ));
    return count > 0;
  }

  /// 设置分组图标与主题色
  Future<bool> updateVisuals(BigInt id, {String? icon, BigInt? color}) async {
    final count = await (_db.update(_db.groups)
          ..where((tbl) => tbl.id.equals(id)))
        .write(GroupsCompanion(
      icon: Value(icon),
      color: Value(color),
      updatedAt: Value(DateTime.now()),
    ));
    return count > 0;
  }

  /// 删除分组
  ///
  /// 说明：
  /// 1. 树形子分组将由 SQLite 外键级联删除 (`onDelete: KeyAction.cascade`)；
  /// 2. 属于该分组的所有图片，其 `groupId` 将自动置空 (`setNull`)，安全退回“未分类”。
  Future<int> deleteGroup(BigInt id) {
    return (_db.delete(_db.groups)..where((tbl) => tbl.id.equals(id))).go();
  }
}

/// 全局 GroupRepository 提供者
final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GroupRepository(db);
});
