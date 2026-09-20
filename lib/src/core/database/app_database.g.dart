// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GroupsTable extends Groups with TableInfo<$GroupsTable, Group> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<BigInt> parentId = GeneratedColumn<BigInt>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "groups" (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _coverImageIdMeta = const VerificationMeta(
    'coverImageId',
  );
  @override
  late final GeneratedColumn<BigInt> coverImageId = GeneratedColumn<BigInt>(
    'cover_image_id',
    aliasedName,
    true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<BigInt> color = GeneratedColumn<BigInt>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    parentId,
    coverImageId,
    icon,
    color,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<Group> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('cover_image_id')) {
      context.handle(
        _coverImageIdMeta,
        coverImageId.isAcceptableOrUnknown(
          data['cover_image_id']!,
          _coverImageIdMeta,
        ),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Group map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Group(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}parent_id'],
      ),
      coverImageId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}cover_image_id'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}color'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GroupsTable createAlias(String alias) {
    return $GroupsTable(attachedDatabase, alias);
  }
}

class Group extends DataClass implements Insertable<Group> {
  final BigInt id;
  final String name;

  /// 自关联父级分组，null 表示根目录；父分组删除时级联删除子分组
  final BigInt? parentId;

  /// 封面图片 ID (弱外键：不加 SQLite 级约束，规避与 Images 表的循环依赖死锁)
  final BigInt? coverImageId;

  /// 无封面时的预设/自选图标标识 (如 'folder', 'palette', 'gamepad')
  final String? icon;

  /// 分组主题色 (ARGB 64位数值，供侧边栏胶囊与文件夹图标着色)
  final BigInt? color;

  /// 排序权重，供侧边栏自定义上下拖拽排序
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Group({
    required this.id,
    required this.name,
    this.parentId,
    this.coverImageId,
    this.icon,
    this.color,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<BigInt>(parentId);
    }
    if (!nullToAbsent || coverImageId != null) {
      map['cover_image_id'] = Variable<BigInt>(coverImageId);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<BigInt>(color);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GroupsCompanion toCompanion(bool nullToAbsent) {
    return GroupsCompanion(
      id: Value(id),
      name: Value(name),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      coverImageId: coverImageId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImageId),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Group.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Group(
      id: serializer.fromJson<BigInt>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentId: serializer.fromJson<BigInt?>(json['parentId']),
      coverImageId: serializer.fromJson<BigInt?>(json['coverImageId']),
      icon: serializer.fromJson<String?>(json['icon']),
      color: serializer.fromJson<BigInt?>(json['color']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'name': serializer.toJson<String>(name),
      'parentId': serializer.toJson<BigInt?>(parentId),
      'coverImageId': serializer.toJson<BigInt?>(coverImageId),
      'icon': serializer.toJson<String?>(icon),
      'color': serializer.toJson<BigInt?>(color),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Group copyWith({
    BigInt? id,
    String? name,
    Value<BigInt?> parentId = const Value.absent(),
    Value<BigInt?> coverImageId = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    Value<BigInt?> color = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Group(
    id: id ?? this.id,
    name: name ?? this.name,
    parentId: parentId.present ? parentId.value : this.parentId,
    coverImageId: coverImageId.present ? coverImageId.value : this.coverImageId,
    icon: icon.present ? icon.value : this.icon,
    color: color.present ? color.value : this.color,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Group copyWithCompanion(GroupsCompanion data) {
    return Group(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      coverImageId: data.coverImageId.present
          ? data.coverImageId.value
          : this.coverImageId,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Group(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId, ')
          ..write('coverImageId: $coverImageId, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    parentId,
    coverImageId,
    icon,
    color,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentId == this.parentId &&
          other.coverImageId == this.coverImageId &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GroupsCompanion extends UpdateCompanion<Group> {
  final Value<BigInt> id;
  final Value<String> name;
  final Value<BigInt?> parentId;
  final Value<BigInt?> coverImageId;
  final Value<String?> icon;
  final Value<BigInt?> color;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const GroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentId = const Value.absent(),
    this.coverImageId = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.parentId = const Value.absent(),
    this.coverImageId = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Group> custom({
    Expression<BigInt>? id,
    Expression<String>? name,
    Expression<BigInt>? parentId,
    Expression<BigInt>? coverImageId,
    Expression<String>? icon,
    Expression<BigInt>? color,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentId != null) 'parent_id': parentId,
      if (coverImageId != null) 'cover_image_id': coverImageId,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GroupsCompanion copyWith({
    Value<BigInt>? id,
    Value<String>? name,
    Value<BigInt?>? parentId,
    Value<BigInt?>? coverImageId,
    Value<String?>? icon,
    Value<BigInt?>? color,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return GroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      coverImageId: coverImageId ?? this.coverImageId,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<BigInt>(parentId.value);
    }
    if (coverImageId.present) {
      map['cover_image_id'] = Variable<BigInt>(coverImageId.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<BigInt>(color.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId, ')
          ..write('coverImageId: $coverImageId, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ImagesTable extends Images with TableInfo<$ImagesTable, Image> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 64,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<BigInt> fileSize = GeneratedColumn<BigInt>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extensionMeta = const VerificationMeta(
    'extension',
  );
  @override
  late final GeneratedColumn<String> extension = GeneratedColumn<String>(
    'extension',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aspectRatioMeta = const VerificationMeta(
    'aspectRatio',
  );
  @override
  late final GeneratedColumn<double> aspectRatio = GeneratedColumn<double>(
    'aspect_ratio',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<BigInt> groupId = GeneratedColumn<BigInt>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "groups" (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sourceUrlMeta = const VerificationMeta(
    'sourceUrl',
  );
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
    'source_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _fileModifiedAtMeta = const VerificationMeta(
    'fileModifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fileModifiedAt =
      GeneratedColumn<DateTime>(
        'file_modified_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sha256,
    fileName,
    relativePath,
    fileSize,
    extension,
    mimeType,
    width,
    height,
    aspectRatio,
    title,
    groupId,
    isFavorite,
    isDeleted,
    sourceUrl,
    notes,
    importedAt,
    fileModifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'images';
  @override
  VerificationContext validateIntegrity(
    Insertable<Image> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('extension')) {
      context.handle(
        _extensionMeta,
        extension.isAcceptableOrUnknown(data['extension']!, _extensionMeta),
      );
    } else if (isInserting) {
      context.missing(_extensionMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('aspect_ratio')) {
      context.handle(
        _aspectRatioMeta,
        aspectRatio.isAcceptableOrUnknown(
          data['aspect_ratio']!,
          _aspectRatioMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('source_url')) {
      context.handle(
        _sourceUrlMeta,
        sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    }
    if (data.containsKey('file_modified_at')) {
      context.handle(
        _fileModifiedAtMeta,
        fileModifiedAt.isAcceptableOrUnknown(
          data['file_modified_at']!,
          _fileModifiedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Image map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Image(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}id'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}file_size'],
      )!,
      extension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extension'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      aspectRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}aspect_ratio'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}group_id'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      sourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      fileModifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}file_modified_at'],
      ),
    );
  }

  @override
  $ImagesTable createAlias(String alias) {
    return $ImagesTable(attachedDatabase, alias);
  }
}

class Image extends DataClass implements Insertable<Image> {
  final BigInt id;

  /// SHA-256 内容唯一哈希，用于防重复导入以及映射缩略图文件名
  final String sha256;
  final String fileName;

  /// 相对于资料库根目录的相对路径，保证便携版在移动盘符或设备时链接不失效
  final String relativePath;
  final BigInt fileSize;
  final String extension;
  final String? mimeType;
  final int? width;
  final int? height;

  /// 宽高比 (width / height)，预先计算以加速瀑布流网格排版
  final double? aspectRatio;

  /// 展示标题，导入时默认取文件名，允许用户重命名且不破坏底层文件链接
  final String title;

  /// 所属主分组，可空；分组删除时置空以回退为“未分类”，保障图片本体安全
  final BigInt? groupId;
  final bool isFavorite;

  /// 软删除标记，true 表示移入废纸篓，物理文件依然保留
  final bool isDeleted;

  /// 素材出处链接 (如 Pixiv, Twitter, Artstation 等网页来源)
  final String? sourceUrl;
  final String? notes;

  /// 入库导入时间，作为物理文件按年月分层存储与默认时间线排序的基准
  final DateTime importedAt;

  /// 原始文件在操作系统上的最后修改时间
  final DateTime? fileModifiedAt;
  const Image({
    required this.id,
    required this.sha256,
    required this.fileName,
    required this.relativePath,
    required this.fileSize,
    required this.extension,
    this.mimeType,
    this.width,
    this.height,
    this.aspectRatio,
    required this.title,
    this.groupId,
    required this.isFavorite,
    required this.isDeleted,
    this.sourceUrl,
    this.notes,
    required this.importedAt,
    this.fileModifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['sha256'] = Variable<String>(sha256);
    map['file_name'] = Variable<String>(fileName);
    map['relative_path'] = Variable<String>(relativePath);
    map['file_size'] = Variable<BigInt>(fileSize);
    map['extension'] = Variable<String>(extension);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || aspectRatio != null) {
      map['aspect_ratio'] = Variable<double>(aspectRatio);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<BigInt>(groupId);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['imported_at'] = Variable<DateTime>(importedAt);
    if (!nullToAbsent || fileModifiedAt != null) {
      map['file_modified_at'] = Variable<DateTime>(fileModifiedAt);
    }
    return map;
  }

  ImagesCompanion toCompanion(bool nullToAbsent) {
    return ImagesCompanion(
      id: Value(id),
      sha256: Value(sha256),
      fileName: Value(fileName),
      relativePath: Value(relativePath),
      fileSize: Value(fileSize),
      extension: Value(extension),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      aspectRatio: aspectRatio == null && nullToAbsent
          ? const Value.absent()
          : Value(aspectRatio),
      title: Value(title),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      isFavorite: Value(isFavorite),
      isDeleted: Value(isDeleted),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      importedAt: Value(importedAt),
      fileModifiedAt: fileModifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(fileModifiedAt),
    );
  }

  factory Image.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Image(
      id: serializer.fromJson<BigInt>(json['id']),
      sha256: serializer.fromJson<String>(json['sha256']),
      fileName: serializer.fromJson<String>(json['fileName']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      fileSize: serializer.fromJson<BigInt>(json['fileSize']),
      extension: serializer.fromJson<String>(json['extension']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      aspectRatio: serializer.fromJson<double?>(json['aspectRatio']),
      title: serializer.fromJson<String>(json['title']),
      groupId: serializer.fromJson<BigInt?>(json['groupId']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      notes: serializer.fromJson<String?>(json['notes']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      fileModifiedAt: serializer.fromJson<DateTime?>(json['fileModifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'sha256': serializer.toJson<String>(sha256),
      'fileName': serializer.toJson<String>(fileName),
      'relativePath': serializer.toJson<String>(relativePath),
      'fileSize': serializer.toJson<BigInt>(fileSize),
      'extension': serializer.toJson<String>(extension),
      'mimeType': serializer.toJson<String?>(mimeType),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'aspectRatio': serializer.toJson<double?>(aspectRatio),
      'title': serializer.toJson<String>(title),
      'groupId': serializer.toJson<BigInt?>(groupId),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'notes': serializer.toJson<String?>(notes),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'fileModifiedAt': serializer.toJson<DateTime?>(fileModifiedAt),
    };
  }

  Image copyWith({
    BigInt? id,
    String? sha256,
    String? fileName,
    String? relativePath,
    BigInt? fileSize,
    String? extension,
    Value<String?> mimeType = const Value.absent(),
    Value<int?> width = const Value.absent(),
    Value<int?> height = const Value.absent(),
    Value<double?> aspectRatio = const Value.absent(),
    String? title,
    Value<BigInt?> groupId = const Value.absent(),
    bool? isFavorite,
    bool? isDeleted,
    Value<String?> sourceUrl = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? importedAt,
    Value<DateTime?> fileModifiedAt = const Value.absent(),
  }) => Image(
    id: id ?? this.id,
    sha256: sha256 ?? this.sha256,
    fileName: fileName ?? this.fileName,
    relativePath: relativePath ?? this.relativePath,
    fileSize: fileSize ?? this.fileSize,
    extension: extension ?? this.extension,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    width: width.present ? width.value : this.width,
    height: height.present ? height.value : this.height,
    aspectRatio: aspectRatio.present ? aspectRatio.value : this.aspectRatio,
    title: title ?? this.title,
    groupId: groupId.present ? groupId.value : this.groupId,
    isFavorite: isFavorite ?? this.isFavorite,
    isDeleted: isDeleted ?? this.isDeleted,
    sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
    notes: notes.present ? notes.value : this.notes,
    importedAt: importedAt ?? this.importedAt,
    fileModifiedAt: fileModifiedAt.present
        ? fileModifiedAt.value
        : this.fileModifiedAt,
  );
  Image copyWithCompanion(ImagesCompanion data) {
    return Image(
      id: data.id.present ? data.id.value : this.id,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      extension: data.extension.present ? data.extension.value : this.extension,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      aspectRatio: data.aspectRatio.present
          ? data.aspectRatio.value
          : this.aspectRatio,
      title: data.title.present ? data.title.value : this.title,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      notes: data.notes.present ? data.notes.value : this.notes,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      fileModifiedAt: data.fileModifiedAt.present
          ? data.fileModifiedAt.value
          : this.fileModifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Image(')
          ..write('id: $id, ')
          ..write('sha256: $sha256, ')
          ..write('fileName: $fileName, ')
          ..write('relativePath: $relativePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('extension: $extension, ')
          ..write('mimeType: $mimeType, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('aspectRatio: $aspectRatio, ')
          ..write('title: $title, ')
          ..write('groupId: $groupId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('notes: $notes, ')
          ..write('importedAt: $importedAt, ')
          ..write('fileModifiedAt: $fileModifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sha256,
    fileName,
    relativePath,
    fileSize,
    extension,
    mimeType,
    width,
    height,
    aspectRatio,
    title,
    groupId,
    isFavorite,
    isDeleted,
    sourceUrl,
    notes,
    importedAt,
    fileModifiedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Image &&
          other.id == this.id &&
          other.sha256 == this.sha256 &&
          other.fileName == this.fileName &&
          other.relativePath == this.relativePath &&
          other.fileSize == this.fileSize &&
          other.extension == this.extension &&
          other.mimeType == this.mimeType &&
          other.width == this.width &&
          other.height == this.height &&
          other.aspectRatio == this.aspectRatio &&
          other.title == this.title &&
          other.groupId == this.groupId &&
          other.isFavorite == this.isFavorite &&
          other.isDeleted == this.isDeleted &&
          other.sourceUrl == this.sourceUrl &&
          other.notes == this.notes &&
          other.importedAt == this.importedAt &&
          other.fileModifiedAt == this.fileModifiedAt);
}

class ImagesCompanion extends UpdateCompanion<Image> {
  final Value<BigInt> id;
  final Value<String> sha256;
  final Value<String> fileName;
  final Value<String> relativePath;
  final Value<BigInt> fileSize;
  final Value<String> extension;
  final Value<String?> mimeType;
  final Value<int?> width;
  final Value<int?> height;
  final Value<double?> aspectRatio;
  final Value<String> title;
  final Value<BigInt?> groupId;
  final Value<bool> isFavorite;
  final Value<bool> isDeleted;
  final Value<String?> sourceUrl;
  final Value<String?> notes;
  final Value<DateTime> importedAt;
  final Value<DateTime?> fileModifiedAt;
  const ImagesCompanion({
    this.id = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.fileName = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.extension = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.aspectRatio = const Value.absent(),
    this.title = const Value.absent(),
    this.groupId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.fileModifiedAt = const Value.absent(),
  });
  ImagesCompanion.insert({
    this.id = const Value.absent(),
    required String sha256,
    required String fileName,
    required String relativePath,
    required BigInt fileSize,
    required String extension,
    this.mimeType = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.aspectRatio = const Value.absent(),
    required String title,
    this.groupId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.fileModifiedAt = const Value.absent(),
  }) : sha256 = Value(sha256),
       fileName = Value(fileName),
       relativePath = Value(relativePath),
       fileSize = Value(fileSize),
       extension = Value(extension),
       title = Value(title);
  static Insertable<Image> custom({
    Expression<BigInt>? id,
    Expression<String>? sha256,
    Expression<String>? fileName,
    Expression<String>? relativePath,
    Expression<BigInt>? fileSize,
    Expression<String>? extension,
    Expression<String>? mimeType,
    Expression<int>? width,
    Expression<int>? height,
    Expression<double>? aspectRatio,
    Expression<String>? title,
    Expression<BigInt>? groupId,
    Expression<bool>? isFavorite,
    Expression<bool>? isDeleted,
    Expression<String>? sourceUrl,
    Expression<String>? notes,
    Expression<DateTime>? importedAt,
    Expression<DateTime>? fileModifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sha256 != null) 'sha256': sha256,
      if (fileName != null) 'file_name': fileName,
      if (relativePath != null) 'relative_path': relativePath,
      if (fileSize != null) 'file_size': fileSize,
      if (extension != null) 'extension': extension,
      if (mimeType != null) 'mime_type': mimeType,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (aspectRatio != null) 'aspect_ratio': aspectRatio,
      if (title != null) 'title': title,
      if (groupId != null) 'group_id': groupId,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (notes != null) 'notes': notes,
      if (importedAt != null) 'imported_at': importedAt,
      if (fileModifiedAt != null) 'file_modified_at': fileModifiedAt,
    });
  }

  ImagesCompanion copyWith({
    Value<BigInt>? id,
    Value<String>? sha256,
    Value<String>? fileName,
    Value<String>? relativePath,
    Value<BigInt>? fileSize,
    Value<String>? extension,
    Value<String?>? mimeType,
    Value<int?>? width,
    Value<int?>? height,
    Value<double?>? aspectRatio,
    Value<String>? title,
    Value<BigInt?>? groupId,
    Value<bool>? isFavorite,
    Value<bool>? isDeleted,
    Value<String?>? sourceUrl,
    Value<String?>? notes,
    Value<DateTime>? importedAt,
    Value<DateTime?>? fileModifiedAt,
  }) {
    return ImagesCompanion(
      id: id ?? this.id,
      sha256: sha256 ?? this.sha256,
      fileName: fileName ?? this.fileName,
      relativePath: relativePath ?? this.relativePath,
      fileSize: fileSize ?? this.fileSize,
      extension: extension ?? this.extension,
      mimeType: mimeType ?? this.mimeType,
      width: width ?? this.width,
      height: height ?? this.height,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      title: title ?? this.title,
      groupId: groupId ?? this.groupId,
      isFavorite: isFavorite ?? this.isFavorite,
      isDeleted: isDeleted ?? this.isDeleted,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      notes: notes ?? this.notes,
      importedAt: importedAt ?? this.importedAt,
      fileModifiedAt: fileModifiedAt ?? this.fileModifiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<BigInt>(fileSize.value);
    }
    if (extension.present) {
      map['extension'] = Variable<String>(extension.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (aspectRatio.present) {
      map['aspect_ratio'] = Variable<double>(aspectRatio.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<BigInt>(groupId.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (fileModifiedAt.present) {
      map['file_modified_at'] = Variable<DateTime>(fileModifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagesCompanion(')
          ..write('id: $id, ')
          ..write('sha256: $sha256, ')
          ..write('fileName: $fileName, ')
          ..write('relativePath: $relativePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('extension: $extension, ')
          ..write('mimeType: $mimeType, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('aspectRatio: $aspectRatio, ')
          ..write('title: $title, ')
          ..write('groupId: $groupId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('notes: $notes, ')
          ..write('importedAt: $importedAt, ')
          ..write('fileModifiedAt: $fileModifiedAt')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<BigInt> color = GeneratedColumn<BigInt>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, color, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final BigInt id;
  final String name;

  /// 标签胶囊颜色 (ARGB 64位数值)
  final BigInt? color;
  final DateTime createdAt;
  const Tag({
    required this.id,
    required this.name,
    this.color,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<BigInt>(color);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<BigInt>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<BigInt?>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<BigInt?>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Tag copyWith({
    BigInt? id,
    String? name,
    Value<BigInt?> color = const Value.absent(),
    DateTime? createdAt,
  }) => Tag(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color.present ? color.value : this.color,
    createdAt: createdAt ?? this.createdAt,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<BigInt> id;
  final Value<String> name;
  final Value<BigInt?> color;
  final Value<DateTime> createdAt;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Tag> custom({
    Expression<BigInt>? id,
    Expression<String>? name,
    Expression<BigInt>? color,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TagsCompanion copyWith({
    Value<BigInt>? id,
    Value<String>? name,
    Value<BigInt?>? color,
    Value<DateTime>? createdAt,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<BigInt>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ImageTagsTable extends ImageTags
    with TableInfo<$ImageTagsTable, ImageTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImageTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _imageIdMeta = const VerificationMeta(
    'imageId',
  );
  @override
  late final GeneratedColumn<BigInt> imageId = GeneratedColumn<BigInt>(
    'image_id',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES images (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<BigInt> tagId = GeneratedColumn<BigInt>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [imageId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'image_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImageTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('image_id')) {
      context.handle(
        _imageIdMeta,
        imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_imageIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {imageId, tagId};
  @override
  ImageTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImageTag(
      imageId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}image_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $ImageTagsTable createAlias(String alias) {
    return $ImageTagsTable(attachedDatabase, alias);
  }
}

class ImageTag extends DataClass implements Insertable<ImageTag> {
  final BigInt imageId;
  final BigInt tagId;
  const ImageTag({required this.imageId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['image_id'] = Variable<BigInt>(imageId);
    map['tag_id'] = Variable<BigInt>(tagId);
    return map;
  }

  ImageTagsCompanion toCompanion(bool nullToAbsent) {
    return ImageTagsCompanion(imageId: Value(imageId), tagId: Value(tagId));
  }

  factory ImageTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImageTag(
      imageId: serializer.fromJson<BigInt>(json['imageId']),
      tagId: serializer.fromJson<BigInt>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'imageId': serializer.toJson<BigInt>(imageId),
      'tagId': serializer.toJson<BigInt>(tagId),
    };
  }

  ImageTag copyWith({BigInt? imageId, BigInt? tagId}) =>
      ImageTag(imageId: imageId ?? this.imageId, tagId: tagId ?? this.tagId);
  ImageTag copyWithCompanion(ImageTagsCompanion data) {
    return ImageTag(
      imageId: data.imageId.present ? data.imageId.value : this.imageId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImageTag(')
          ..write('imageId: $imageId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(imageId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageTag &&
          other.imageId == this.imageId &&
          other.tagId == this.tagId);
}

class ImageTagsCompanion extends UpdateCompanion<ImageTag> {
  final Value<BigInt> imageId;
  final Value<BigInt> tagId;
  final Value<int> rowid;
  const ImageTagsCompanion({
    this.imageId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImageTagsCompanion.insert({
    required BigInt imageId,
    required BigInt tagId,
    this.rowid = const Value.absent(),
  }) : imageId = Value(imageId),
       tagId = Value(tagId);
  static Insertable<ImageTag> custom({
    Expression<BigInt>? imageId,
    Expression<BigInt>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (imageId != null) 'image_id': imageId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImageTagsCompanion copyWith({
    Value<BigInt>? imageId,
    Value<BigInt>? tagId,
    Value<int>? rowid,
  }) {
    return ImageTagsCompanion(
      imageId: imageId ?? this.imageId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (imageId.present) {
      map['image_id'] = Variable<BigInt>(imageId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<BigInt>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageTagsCompanion(')
          ..write('imageId: $imageId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GroupsTable groups = $GroupsTable(this);
  late final $ImagesTable images = $ImagesTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $ImageTagsTable imageTags = $ImageTagsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    groups,
    images,
    tags,
    imageTags,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('images', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'images',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('image_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('image_tags', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GroupsTableCreateCompanionBuilder =
    GroupsCompanion Function({
      Value<BigInt> id,
      required String name,
      Value<BigInt?> parentId,
      Value<BigInt?> coverImageId,
      Value<String?> icon,
      Value<BigInt?> color,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$GroupsTableUpdateCompanionBuilder =
    GroupsCompanion Function({
      Value<BigInt> id,
      Value<String> name,
      Value<BigInt?> parentId,
      Value<BigInt?> coverImageId,
      Value<String?> icon,
      Value<BigInt?> color,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$GroupsTableReferences
    extends BaseReferences<_$AppDatabase, $GroupsTable, Group> {
  $$GroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupsTable _parentIdTable(_$AppDatabase db) =>
      db.groups.createAlias('groups__parent_id__groups__id');

  $$GroupsTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<BigInt>('parent_id');
    if ($_column == null) return null;
    final manager = $$GroupsTableTableManager(
      $_db,
      $_db.groups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ImagesTable, List<Image>> _imagesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.images,
    aliasName: 'groups__id__images__group_id',
  );

  $$ImagesTableProcessedTableManager get imagesRefs {
    final manager = $$ImagesTableTableManager(
      $_db,
      $_db.images,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<BigInt>('id')!));

    final cache = $_typedResult.readTableOrNull(_imagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupsTableFilterComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get coverImageId => $composableBuilder(
    column: $table.coverImageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GroupsTableFilterComposer get parentId {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableFilterComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> imagesRefs(
    Expression<bool> Function($$ImagesTableFilterComposer f) f,
  ) {
    final $$ImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableFilterComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get coverImageId => $composableBuilder(
    column: $table.coverImageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GroupsTableOrderingComposer get parentId {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableOrderingComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<BigInt> get coverImageId => $composableBuilder(
    column: $table.coverImageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<BigInt> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GroupsTableAnnotationComposer get parentId {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> imagesRefs<T extends Object>(
    Expression<T> Function($$ImagesTableAnnotationComposer a) f,
  ) {
    final $$ImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupsTable,
          Group,
          $$GroupsTableFilterComposer,
          $$GroupsTableOrderingComposer,
          $$GroupsTableAnnotationComposer,
          $$GroupsTableCreateCompanionBuilder,
          $$GroupsTableUpdateCompanionBuilder,
          (Group, $$GroupsTableReferences),
          Group,
          PrefetchHooks Function({bool parentId, bool imagesRefs})
        > {
  $$GroupsTableTableManager(_$AppDatabase db, $GroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<BigInt?> parentId = const Value.absent(),
                Value<BigInt?> coverImageId = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<BigInt?> color = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GroupsCompanion(
                id: id,
                name: name,
                parentId: parentId,
                coverImageId: coverImageId,
                icon: icon,
                color: color,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required String name,
                Value<BigInt?> parentId = const Value.absent(),
                Value<BigInt?> coverImageId = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<BigInt?> color = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GroupsCompanion.insert(
                id: id,
                name: name,
                parentId: parentId,
                coverImageId: coverImageId,
                icon: icon,
                color: color,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GroupsTable, Group>(table),
                  $$GroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parentId = false, imagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (imagesRefs) db.images],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.parentId,
                                referencedTable: $$GroupsTableReferences
                                    ._parentIdTable(db),
                                referencedColumn: $$GroupsTableReferences
                                    ._parentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (imagesRefs)
                    await $_getPrefetchedData<Group, $GroupsTable, Image>(
                      currentTable: table,
                      referencedTable: $$GroupsTableReferences._imagesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$GroupsTableReferences(db, table, p0).imagesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupsTable,
      Group,
      $$GroupsTableFilterComposer,
      $$GroupsTableOrderingComposer,
      $$GroupsTableAnnotationComposer,
      $$GroupsTableCreateCompanionBuilder,
      $$GroupsTableUpdateCompanionBuilder,
      (Group, $$GroupsTableReferences),
      Group,
      PrefetchHooks Function({bool parentId, bool imagesRefs})
    >;
typedef $$ImagesTableCreateCompanionBuilder =
    ImagesCompanion Function({
      Value<BigInt> id,
      required String sha256,
      required String fileName,
      required String relativePath,
      required BigInt fileSize,
      required String extension,
      Value<String?> mimeType,
      Value<int?> width,
      Value<int?> height,
      Value<double?> aspectRatio,
      required String title,
      Value<BigInt?> groupId,
      Value<bool> isFavorite,
      Value<bool> isDeleted,
      Value<String?> sourceUrl,
      Value<String?> notes,
      Value<DateTime> importedAt,
      Value<DateTime?> fileModifiedAt,
    });
typedef $$ImagesTableUpdateCompanionBuilder =
    ImagesCompanion Function({
      Value<BigInt> id,
      Value<String> sha256,
      Value<String> fileName,
      Value<String> relativePath,
      Value<BigInt> fileSize,
      Value<String> extension,
      Value<String?> mimeType,
      Value<int?> width,
      Value<int?> height,
      Value<double?> aspectRatio,
      Value<String> title,
      Value<BigInt?> groupId,
      Value<bool> isFavorite,
      Value<bool> isDeleted,
      Value<String?> sourceUrl,
      Value<String?> notes,
      Value<DateTime> importedAt,
      Value<DateTime?> fileModifiedAt,
    });

final class $$ImagesTableReferences
    extends BaseReferences<_$AppDatabase, $ImagesTable, Image> {
  $$ImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupsTable _groupIdTable(_$AppDatabase db) =>
      db.groups.createAlias('images__group_id__groups__id');

  $$GroupsTableProcessedTableManager? get groupId {
    final $_column = $_itemColumn<BigInt>('group_id');
    if ($_column == null) return null;
    final manager = $$GroupsTableTableManager(
      $_db,
      $_db.groups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ImageTagsTable, List<ImageTag>>
  _imageTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.imageTags,
    aliasName: 'images__id__image_tags__image_id',
  );

  $$ImageTagsTableProcessedTableManager get imageTagsRefs {
    final manager = $$ImageTagsTableTableManager(
      $_db,
      $_db.imageTags,
    ).filter((f) => f.imageId.id.sqlEquals($_itemColumn<BigInt>('id')!));

    final cache = $_typedResult.readTableOrNull(_imageTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ImagesTableFilterComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get aspectRatio => $composableBuilder(
    column: $table.aspectRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fileModifiedAt => $composableBuilder(
    column: $table.fileModifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GroupsTableFilterComposer get groupId {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableFilterComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> imageTagsRefs(
    Expression<bool> Function($$ImageTagsTableFilterComposer f) f,
  ) {
    final $$ImageTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.imageTags,
      getReferencedColumn: (t) => t.imageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageTagsTableFilterComposer(
            $db: $db,
            $table: $db.imageTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get aspectRatio => $composableBuilder(
    column: $table.aspectRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fileModifiedAt => $composableBuilder(
    column: $table.fileModifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GroupsTableOrderingComposer get groupId {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableOrderingComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<BigInt> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get extension =>
      $composableBuilder(column: $table.extension, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get aspectRatio => $composableBuilder(
    column: $table.aspectRatio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fileModifiedAt => $composableBuilder(
    column: $table.fileModifiedAt,
    builder: (column) => column,
  );

  $$GroupsTableAnnotationComposer get groupId {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> imageTagsRefs<T extends Object>(
    Expression<T> Function($$ImageTagsTableAnnotationComposer a) f,
  ) {
    final $$ImageTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.imageTags,
      getReferencedColumn: (t) => t.imageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.imageTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImagesTable,
          Image,
          $$ImagesTableFilterComposer,
          $$ImagesTableOrderingComposer,
          $$ImagesTableAnnotationComposer,
          $$ImagesTableCreateCompanionBuilder,
          $$ImagesTableUpdateCompanionBuilder,
          (Image, $$ImagesTableReferences),
          Image,
          PrefetchHooks Function({bool groupId, bool imageTagsRefs})
        > {
  $$ImagesTableTableManager(_$AppDatabase db, $ImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<BigInt> fileSize = const Value.absent(),
                Value<String> extension = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<double?> aspectRatio = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<BigInt?> groupId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<DateTime?> fileModifiedAt = const Value.absent(),
              }) => ImagesCompanion(
                id: id,
                sha256: sha256,
                fileName: fileName,
                relativePath: relativePath,
                fileSize: fileSize,
                extension: extension,
                mimeType: mimeType,
                width: width,
                height: height,
                aspectRatio: aspectRatio,
                title: title,
                groupId: groupId,
                isFavorite: isFavorite,
                isDeleted: isDeleted,
                sourceUrl: sourceUrl,
                notes: notes,
                importedAt: importedAt,
                fileModifiedAt: fileModifiedAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required String sha256,
                required String fileName,
                required String relativePath,
                required BigInt fileSize,
                required String extension,
                Value<String?> mimeType = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<double?> aspectRatio = const Value.absent(),
                required String title,
                Value<BigInt?> groupId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<DateTime?> fileModifiedAt = const Value.absent(),
              }) => ImagesCompanion.insert(
                id: id,
                sha256: sha256,
                fileName: fileName,
                relativePath: relativePath,
                fileSize: fileSize,
                extension: extension,
                mimeType: mimeType,
                width: width,
                height: height,
                aspectRatio: aspectRatio,
                title: title,
                groupId: groupId,
                isFavorite: isFavorite,
                isDeleted: isDeleted,
                sourceUrl: sourceUrl,
                notes: notes,
                importedAt: importedAt,
                fileModifiedAt: fileModifiedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ImagesTable, Image>(table),
                  $$ImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false, imageTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (imageTagsRefs) db.imageTags],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable: $$ImagesTableReferences
                                    ._groupIdTable(db),
                                referencedColumn: $$ImagesTableReferences
                                    ._groupIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (imageTagsRefs)
                    await $_getPrefetchedData<Image, $ImagesTable, ImageTag>(
                      currentTable: table,
                      referencedTable: $$ImagesTableReferences
                          ._imageTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ImagesTableReferences(db, table, p0).imageTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.imageId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImagesTable,
      Image,
      $$ImagesTableFilterComposer,
      $$ImagesTableOrderingComposer,
      $$ImagesTableAnnotationComposer,
      $$ImagesTableCreateCompanionBuilder,
      $$ImagesTableUpdateCompanionBuilder,
      (Image, $$ImagesTableReferences),
      Image,
      PrefetchHooks Function({bool groupId, bool imageTagsRefs})
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      Value<BigInt> id,
      required String name,
      Value<BigInt?> color,
      Value<DateTime> createdAt,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<BigInt> id,
      Value<String> name,
      Value<BigInt?> color,
      Value<DateTime> createdAt,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ImageTagsTable, List<ImageTag>>
  _imageTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.imageTags,
    aliasName: 'tags__id__image_tags__tag_id',
  );

  $$ImageTagsTableProcessedTableManager get imageTagsRefs {
    final manager = $$ImageTagsTableTableManager(
      $_db,
      $_db.imageTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<BigInt>('id')!));

    final cache = $_typedResult.readTableOrNull(_imageTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> imageTagsRefs(
    Expression<bool> Function($$ImageTagsTableFilterComposer f) f,
  ) {
    final $$ImageTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.imageTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageTagsTableFilterComposer(
            $db: $db,
            $table: $db.imageTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<BigInt> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> imageTagsRefs<T extends Object>(
    Expression<T> Function($$ImageTagsTableAnnotationComposer a) f,
  ) {
    final $$ImageTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.imageTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.imageTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({bool imageTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<BigInt?> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required String name,
                Value<BigInt?> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, Tag>(table),
                  $$TagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({imageTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (imageTagsRefs) db.imageTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (imageTagsRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, ImageTag>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences
                          ._imageTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableReferences(db, table, p0).imageTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool imageTagsRefs})
    >;
typedef $$ImageTagsTableCreateCompanionBuilder =
    ImageTagsCompanion Function({
      required BigInt imageId,
      required BigInt tagId,
      Value<int> rowid,
    });
typedef $$ImageTagsTableUpdateCompanionBuilder =
    ImageTagsCompanion Function({
      Value<BigInt> imageId,
      Value<BigInt> tagId,
      Value<int> rowid,
    });

final class $$ImageTagsTableReferences
    extends BaseReferences<_$AppDatabase, $ImageTagsTable, ImageTag> {
  $$ImageTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ImagesTable _imageIdTable(_$AppDatabase db) =>
      db.images.createAlias('image_tags__image_id__images__id');

  $$ImagesTableProcessedTableManager get imageId {
    final $_column = $_itemColumn<BigInt>('image_id')!;

    final manager = $$ImagesTableTableManager(
      $_db,
      $_db.images,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_imageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias('image_tags__tag_id__tags__id');

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<BigInt>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ImageTagsTableFilterComposer
    extends Composer<_$AppDatabase, $ImageTagsTable> {
  $$ImageTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ImagesTableFilterComposer get imageId {
    final $$ImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.imageId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableFilterComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ImageTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $ImageTagsTable> {
  $$ImageTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ImagesTableOrderingComposer get imageId {
    final $$ImagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.imageId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableOrderingComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ImageTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImageTagsTable> {
  $$ImageTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ImagesTableAnnotationComposer get imageId {
    final $$ImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.imageId,
      referencedTable: $db.images,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.images,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ImageTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImageTagsTable,
          ImageTag,
          $$ImageTagsTableFilterComposer,
          $$ImageTagsTableOrderingComposer,
          $$ImageTagsTableAnnotationComposer,
          $$ImageTagsTableCreateCompanionBuilder,
          $$ImageTagsTableUpdateCompanionBuilder,
          (ImageTag, $$ImageTagsTableReferences),
          ImageTag,
          PrefetchHooks Function({bool imageId, bool tagId})
        > {
  $$ImageTagsTableTableManager(_$AppDatabase db, $ImageTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImageTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImageTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImageTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> imageId = const Value.absent(),
                Value<BigInt> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImageTagsCompanion(
                imageId: imageId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required BigInt imageId,
                required BigInt tagId,
                Value<int> rowid = const Value.absent(),
              }) => ImageTagsCompanion.insert(
                imageId: imageId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ImageTagsTable, ImageTag>(table),
                  $$ImageTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({imageId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (imageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.imageId,
                                referencedTable: $$ImageTagsTableReferences
                                    ._imageIdTable(db),
                                referencedColumn: $$ImageTagsTableReferences
                                    ._imageIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$ImageTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$ImageTagsTableReferences
                                    ._tagIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ImageTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImageTagsTable,
      ImageTag,
      $$ImageTagsTableFilterComposer,
      $$ImageTagsTableOrderingComposer,
      $$ImageTagsTableAnnotationComposer,
      $$ImageTagsTableCreateCompanionBuilder,
      $$ImageTagsTableUpdateCompanionBuilder,
      (ImageTag, $$ImageTagsTableReferences),
      ImageTag,
      PrefetchHooks Function({bool imageId, bool tagId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GroupsTableTableManager get groups =>
      $$GroupsTableTableManager(_db, _db.groups);
  $$ImagesTableTableManager get images =>
      $$ImagesTableTableManager(_db, _db.images);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$ImageTagsTableTableManager get imageTags =>
      $$ImageTagsTableTableManager(_db, _db.imageTags);
}
