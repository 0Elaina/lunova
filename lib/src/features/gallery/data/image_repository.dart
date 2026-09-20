import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

/// 图片资产仓储
///
/// 封装对 Images 表的所有 CRUD 操作，向应用层提供语义清晰的方法与响应式 Stream 流。
class ImageRepository {
  ImageRepository(this._db);

  final AppDatabase _db;

  /// 根据 SHA-256 哈希查询图片 (导入时用于秒级去重排查)
  Future<Image?> findBySha256(String sha256) {
    return (_db.select(_db.images)..where((tbl) => tbl.sha256.equals(sha256)))
        .getSingleOrNull();
  }

  /// 根据 ID 查询单个图片资产详情
  Future<Image?> findById(BigInt id) {
    return (_db.select(_db.images)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// 插入新图片记录并返回插入后的完整实体 (包含数据库自增生成的 BigInt id)
  Future<Image> insertImage(ImagesCompanion companion) {
    return _db.into(_db.images).insertReturning(companion);
  }

  /// 响应式监听图片列表 (用于瀑布流网格展示)
  ///
  /// - [groupId]：指定分组 ID；为空时查询全部
  /// - [onlyFavorites]：是否仅看收藏
  /// - [includeDeleted]：是否包含废纸篓中的图片（默认过滤掉已删除项）
  /// - 排序默认按 [importedAt] 倒序排列（最新导入在前）
  Stream<List<Image>> watchImages({
    BigInt? groupId,
    bool onlyFavorites = false,
    bool includeDeleted = false,
  }) {
    final query = _db.select(_db.images);

    query.where((tbl) {
      final conditions = <Expression<bool>>[];

      // 废纸篓过滤
      if (!includeDeleted) {
        conditions.add(tbl.isDeleted.equals(false));
      }

      // 收藏过滤
      if (onlyFavorites) {
        conditions.add(tbl.isFavorite.equals(true));
      }

      // 分组过滤
      if (groupId != null) {
        conditions.add(tbl.groupId.equals(groupId));
      }

      return conditions.isEmpty
          ? const Constant(true)
          : conditions.reduce((a, b) => a & b);
    });

    query.orderBy([
      (tbl) => OrderingTerm(expression: tbl.importedAt, mode: OrderingMode.desc),
    ]);

    return query.watch();
  }

  /// 切换收藏状态
  Future<bool> toggleFavorite(BigInt id, bool isFavorite) async {
    final count = await (_db.update(_db.images)
          ..where((tbl) => tbl.id.equals(id)))
        .write(ImagesCompanion(isFavorite: Value(isFavorite)));
    return count > 0;
  }

  /// 软删除：将图片移入废纸篓 (不删除物理原文件)
  Future<bool> softDelete(BigInt id) async {
    final count = await (_db.update(_db.images)
          ..where((tbl) => tbl.id.equals(id)))
        .write(const ImagesCompanion(isDeleted: Value(true)));
    return count > 0;
  }

  /// 废纸篓还原
  Future<bool> restoreFromTrash(BigInt id) async {
    final count = await (_db.update(_db.images)
          ..where((tbl) => tbl.id.equals(id)))
        .write(const ImagesCompanion(isDeleted: Value(false)));
    return count > 0;
  }

  /// 物理彻底删除记录
  Future<int> permanentlyDelete(BigInt id) {
    return (_db.delete(_db.images)..where((tbl) => tbl.id.equals(id))).go();
  }
}

/// 全局 ImageRepository 提供者
final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ImageRepository(db);
});
