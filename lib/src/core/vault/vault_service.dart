import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class VaultService {
  // 库标识文件名：用以判定此目录是否为 Lunova 资料库
  static const String markerFileName = '.lunova_vault';
  // 开发模式下，默认资料库目录名
  static const String devVaultDirName = 'dev_vault';
  // 发布模式下，默认资料库目录名
  static const String releaseWindowsVaultDirName = 'vault';
  // Android 平台下，默认资料库目录名
  static const String releaseAndroidVaultDirName = 'LunovaVault';
  // 本地数据库文件名：Drift SQLite 数据库文件
  static const String dbFileName = 'lunova.db';
  // 缩略图缓存目录名：带点号的隐藏目录
  static const String thumbnailsDirName = '.thumbnails';
  // 原图存储目录名：存放用户原始图片的根目录
  static const String originalsDirName = 'originals';

  /// 获取默认资料库目录路径
  Future<String> getDefaultVaultPath() async {
    if (Platform.isWindows) {
      // 开发模式下，默认资料库目录为当前目录下的 dev_vault 目录
      if (kDebugMode) {
        return p.normalize(p.join(Directory.current.path, devVaultDirName));
      } else {
        // 发布模式下，默认资料库目录为可执行文件所在目录下的 vault 目录
        return p.normalize(
          p.join(
            File(Platform.resolvedExecutable).parent.path,
            releaseWindowsVaultDirName,
          ),
        );
      }
    } else if (Platform.isAndroid) {
      final docDir = await getApplicationDocumentsDirectory();
      return p.normalize(p.join(docDir.path, releaseAndroidVaultDirName));
    } else {
      throw UnimplementedError('不支持当前平台: ${Platform.operatingSystem}');
    }
  }

  /// 初始化资料库目录结构
  Future<void> initializeVault(String vaultPath) async {
    final rootDir = Directory(vaultPath);
    if (!await rootDir.exists()) {
      await rootDir.create(recursive: true);
    }
    final fullOriginalsDir = p.join(vaultPath, originalsDirName);
    final fullThumbnailsDir = p.join(vaultPath, thumbnailsDirName);
    if (!await Directory(fullOriginalsDir).exists()) {
      await Directory(fullOriginalsDir).create(recursive: true);
    }
    if (!await Directory(fullThumbnailsDir).exists()) {
      await Directory(fullThumbnailsDir).create(recursive: true);
    }
    final markerFile = File(p.join(vaultPath, markerFileName));
    // 如果库标识文件不存在，则创建并写入默认元数据
    if (!await markerFile.exists()) {
      final meta = {
        'version': 1,
        'createdAt': DateTime.now().toIso8601String(),
      };
      await markerFile.writeAsString(jsonEncode(meta));
    }
  }

  /// 获取资料库数据库文件路径
  String getDbPath(String vaultPath) => p.join(vaultPath, dbFileName);

  /// 获取资料库缩略图缓存文件路径
  String getThumbnailsPath(String vaultPath, String sha256) =>
      p.join(vaultPath, thumbnailsDirName, '$sha256.webp');

  /// 获取资料库原始图片文件路径 (按导入时间年月归档)
  String getOriginalsPath(
    String vaultPath,
    DateTime importedAt,
    String fileName,
  ) {
    final year = importedAt.year.toString();
    final month = importedAt.month.toString().padLeft(2, '0');
    return p.join(vaultPath, originalsDirName, year, month, fileName);
  }
}

/// 全局只读 VaultService 提供者
final vaultServiceProvider = Provider<VaultService>((ref) {
  return VaultService();
});
