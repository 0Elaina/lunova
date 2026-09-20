import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Lunova 多维文字排版体系 (Typography System)
///
/// 严格对齐 Anime UI Craft 原型中的三套混合排版体系：
/// 1. [display]: Plus Jakarta Sans —— 现代几何骨架，用于品牌 Logotype、大标题、英数展台大字
/// 2. [body]: Zen Maru Gothic —— 日系治愈微圆体，用于正文阐述、标签、交互按钮、诗意副标题
/// 3. [mono]: JetBrains Mono —— 工业级等宽字体，用于技术哈希、尺寸分辨率、存储体积与时间戳
abstract final class AppTypography {
  /// 后备字体族（网络异常或纯离线时的优雅回退链）
  static const List<String> fallbackSans = [
    '-apple-system',
    'BlinkMacSystemFont',
    'Segoe UI',
    'PingFang SC',
    'Hiragino Sans GB',
    'Microsoft YaHei',
    'sans-serif',
  ];

  static const List<String> fallbackMono = [
    'Cascadia Mono',
    'Consolas',
    'Menlo',
    'Courier New',
    'monospace',
  ];

  /// 获取现代几何 Display 字体样式 (Plus Jakarta Sans)
  static TextStyle display({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.plusJakartaSans(
      textStyle: textStyle,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// 获取日系治愈微圆 Body 字体样式 (Zen Maru Gothic)
  static TextStyle body({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.zenMaruGothic(
      textStyle: textStyle,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// 获取工业等宽 Mono 字体样式 (JetBrains Mono)
  static TextStyle mono({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.jetBrainsMono(
      textStyle: textStyle,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// 构建全局融合 TextTheme
  ///
  /// 大标题与展示位注入 [Plus Jakarta Sans]，正文与交互位注入 [Zen Maru Gothic]
  static TextTheme buildTextTheme({required Color defaultColor}) {
    final baseTextTheme = Typography.material2021().black.apply(
          bodyColor: defaultColor,
          displayColor: defaultColor,
        );

    return TextTheme(
      // Display 展台与巨幅标题
      displayLarge: display(
        textStyle: baseTextTheme.displayLarge,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.02,
      ),
      displayMedium: display(
        textStyle: baseTextTheme.displayMedium,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.01,
      ),
      displaySmall: display(
        textStyle: baseTextTheme.displaySmall,
        fontWeight: FontWeight.w700,
      ),

      // Headline 页面级主标题
      headlineLarge: display(
        textStyle: baseTextTheme.headlineLarge,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: display(
        textStyle: baseTextTheme.headlineMedium,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: display(
        textStyle: baseTextTheme.headlineSmall,
        fontWeight: FontWeight.w600,
      ),

      // Title 区域/卡片标题
      titleLarge: body(
        textStyle: baseTextTheme.titleLarge,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: body(
        textStyle: baseTextTheme.titleMedium,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: body(
        textStyle: baseTextTheme.titleSmall,
        fontWeight: FontWeight.w500,
      ),

      // Body 叙事正文
      bodyLarge: body(
        textStyle: baseTextTheme.bodyLarge,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      bodyMedium: body(
        textStyle: baseTextTheme.bodyMedium,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: body(
        textStyle: baseTextTheme.bodySmall,
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),

      // Label 按钮、徽标与胶囊标签
      labelLarge: body(
        textStyle: baseTextTheme.labelLarge,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.02,
      ),
      labelMedium: body(
        textStyle: baseTextTheme.labelMedium,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: mono(
        textStyle: baseTextTheme.labelSmall,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.04,
      ),
    );
  }
}
