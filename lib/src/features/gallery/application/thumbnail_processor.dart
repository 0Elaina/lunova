import 'dart:io';
import 'dart:isolate';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

/// 缩略图处理与元数据提取结果
class ThumbnailProcessResult {
  /// 生成的缩略图绝对文件路径
  final String thumbnailPath;

  /// 原图的原始像素宽度
  final int width;

  /// 原图的原始像素高度
  final int height;

  /// 原图的宽高比（width / height）
  final double aspectRatio;

  const ThumbnailProcessResult({
    required this.thumbnailPath,
    required this.width,
    required this.height,
    required this.aspectRatio,
  });
}

/// 传递给后台 Isolate 的纯数据参数包
class ThumbnailTaskParams {
  /// 原图文件绝对路径
  final String inputPath;

  /// 缩略图输出绝对路径
  final String outputPath;

  /// 缩略图最大长边尺寸（默认 400px）
  final int maxLongEdge;

  /// WebP 编码质量（0-100，默认 80）
  final int quality;

  const ThumbnailTaskParams({
    required this.inputPath,
    required this.outputPath,
    this.maxLongEdge = 400,
    this.quality = 80,
  });
}

/// 缩略图生成与图像算力处理器
///
/// 核心职责：
/// 1. 将耗时的图像解码、等比缩放、WebP 编码完全放入独立的后台 Isolate 运行；
/// 2. 保证 Flutter 主 UI 线程绝对平滑（0 帧率下降）；
/// 3. 在解码阶段同步提取原图原始像素宽高与宽高比，避免后续重复解码。
class ThumbnailProcessor {
  const ThumbnailProcessor();

  /// 在独立后台 Isolate 中生成 400px WebP 缩略图并提取原图尺寸元数据
  Future<ThumbnailProcessResult> process({
    required String inputPath,
    required String outputPath,
    int maxLongEdge = 400,
    int quality = 80,
  }) {
    final params = ThumbnailTaskParams(
      inputPath: inputPath,
      outputPath: outputPath,
      maxLongEdge: maxLongEdge,
      quality: quality,
    );

    // 采用 Dart 3 标准轻量 Isolate.run，计算完毕后自动销毁并回收算力线程
    return Isolate.run(() => _executeTask(params));
  }

  /// 在独立 Isolate 中执行的静态计算任务
  static Future<ThumbnailProcessResult> _executeTask(ThumbnailTaskParams params) async {
    final inputFile = File(params.inputPath);
    if (!inputFile.existsSync()) {
      throw FileSystemException('待处理图片文件不存在', params.inputPath);
    }

    // 1. 异步解码原图（自动识别 JPG, PNG, GIF, WebP, BMP 等主流格式）
    final image = await img.decodeImageFile(params.inputPath);
    if (image == null) {
      throw FormatException('无法解析图片，格式不支持或文件已损坏: ${params.inputPath}');
    }

    // 2. 提取原图真实尺寸元数据
    final int originalWidth = image.width;
    final int originalHeight = image.height;
    final double aspectRatio = originalHeight == 0 ? 1.0 : originalWidth / originalHeight;

    // 3. 计算缩略图尺寸（长边等比缩放，小图不强行放大拉伸）
    img.Image thumbnail = image;
    final int currentMaxEdge = originalWidth > originalHeight ? originalWidth : originalHeight;

    if (currentMaxEdge > params.maxLongEdge) {
      if (originalWidth >= originalHeight) {
        // 横图或正方形图：以宽度为基准等比缩放
        thumbnail = img.copyResize(
          image,
          width: params.maxLongEdge,
          interpolation: img.Interpolation.linear,
        );
      } else {
        // 竖图：以高度为基准等比缩放
        thumbnail = img.copyResize(
          image,
          height: params.maxLongEdge,
          interpolation: img.Interpolation.linear,
        );
      }
    }

    // 4. 确保输出目录（.thumbnails/）物理存在
    final outputFile = File(params.outputPath);
    final parentDir = outputFile.parent;
    if (!parentDir.existsSync()) {
      parentDir.createSync(recursive: true);
    }

    // 5. 编码为 WebP 格式并安全落盘
    final webpBytes = img.encodeWebP(thumbnail, quality: params.quality);
    await outputFile.writeAsBytes(webpBytes, flush: true);

    return ThumbnailProcessResult(
      thumbnailPath: params.outputPath,
      width: originalWidth,
      height: originalHeight,
      aspectRatio: aspectRatio,
    );
  }
}

/// ThumbnailProcessor 的全局只读 Riverpod Provider
final thumbnailProcessorProvider = Provider<ThumbnailProcessor>((ref) {
  return const ThumbnailProcessor();
});
