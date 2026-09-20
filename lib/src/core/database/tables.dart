import 'package:drift/drift.dart';

/// 分组表
///
/// 树形层级目录结构，每张图片有且仅有一个主归属分组。
/// 支持无限级子目录（通过 [parentId] 自关联）、手动排序以及视觉封面/图标。
class Groups extends Table {
  Int64Column get id => int64().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// 自关联父级分组，null 表示根目录；父分组删除时级联删除子分组
  Int64Column get parentId => int64().nullable().references(
        Groups,
        #id,
        onDelete: KeyAction.cascade,
      )();

  /// 封面图片 ID (弱外键：不加 SQLite 级约束，规避与 Images 表的循环依赖死锁)
  Int64Column get coverImageId => int64().nullable()();

  /// 无封面时的预设/自选图标标识 (如 'folder', 'palette', 'gamepad')
  TextColumn get icon => text().nullable()();

  /// 分组主题色 (ARGB 64位数值，供侧边栏胶囊与文件夹图标着色)
  Int64Column get color => int64().nullable()();

  /// 排序权重，供侧边栏自定义上下拖拽排序
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 通用图片资产主表
///
/// 存储所有纳管图片文件的元数据、视觉规格与组织属性。
class Images extends Table {
  Int64Column get id => int64().autoIncrement()();

  /// SHA-256 内容唯一哈希，用于防重复导入以及映射缩略图文件名
  TextColumn get sha256 => text().withLength(min: 64, max: 64).unique()();

  TextColumn get fileName => text()();

  /// 相对于资料库根目录的相对路径，保证便携版在移动盘符或设备时链接不失效
  TextColumn get relativePath => text()();

  Int64Column get fileSize => int64()();
  TextColumn get extension => text()();
  TextColumn get mimeType => text().nullable()();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();

  /// 宽高比 (width / height)，预先计算以加速瀑布流网格排版
  RealColumn get aspectRatio => real().nullable()();

  /// 展示标题，导入时默认取文件名，允许用户重命名且不破坏底层文件链接
  TextColumn get title => text()();

  /// 所属主分组，可空；分组删除时置空以回退为“未分类”，保障图片本体安全
  Int64Column get groupId => int64().nullable().references(
        Groups,
        #id,
        onDelete: KeyAction.setNull,
      )();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  /// 软删除标记，true 表示移入废纸篓，物理文件依然保留
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  /// 素材出处链接 (如 Pixiv, Twitter, Artstation 等网页来源)
  TextColumn get sourceUrl => text().nullable()();

  TextColumn get notes => text().nullable()();

  /// 入库导入时间，作为物理文件按年月分层存储与默认时间线排序的基准
  DateTimeColumn get importedAt => dateTime().withDefault(currentDateAndTime)();

  /// 原始文件在操作系统上的最后修改时间
  DateTimeColumn get fileModifiedAt => dateTime().nullable()();
}

/// 多维标签表
///
/// 用于跨分组对图片进行横向属性标记与交集/并集检索。
class Tags extends Table {
  Int64Column get id => int64().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50).unique()();

  /// 标签胶囊颜色 (ARGB 64位数值)
  Int64Column get color => int64().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 图片与标签的多对多关联表
class ImageTags extends Table {
  Int64Column get imageId => int64().references(
        Images,
        #id,
        onDelete: KeyAction.cascade,
      )();

  Int64Column get tagId => int64().references(
        Tags,
        #id,
        onDelete: KeyAction.cascade,
      )();

  /// 联合主键，确保同一张图片不会重复绑定同一个标签
  @override
  Set<Column> get primaryKey => {imageId, tagId};
}
