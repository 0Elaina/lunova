import 'package:flutter/material.dart';
import 'app_theme_tokens.dart';
import 'tokens.dart';
import 'typography.dart';

export 'app_theme_tokens.dart';
export 'tokens.dart';
export 'typography.dart';

/// Lunova 全局主题装配工厂
///
/// 职责：将 [AppSkyTheme] 枚举解析装配为完整的 Flutter 原生 [ThemeData]，
/// 同时挂载 [AppThemeTokens] 物理微距扩展。
abstract final class AppTheme {
  /// 根据指定天光模式装配 ThemeData
  static ThemeData buildTheme(AppSkyTheme skyTheme) {
    // 1. 抽取对应天光的物理代币
    final tokens = _resolveTokens(skyTheme);

    // 2. 组装 Material 3 基础色彩方案
    final colorScheme = ColorScheme(
      brightness: skyTheme.brightness,
      primary: tokens.accents.periwinkle,
      onPrimary: Colors.white,
      primaryContainer: tokens.accents.periwinkleLight,
      onPrimaryContainer: tokens.accents.periwinkle,
      secondary: tokens.accents.sakura,
      onSecondary: Colors.white,
      secondaryContainer: tokens.accents.sakuraLight,
      onSecondaryContainer: tokens.accents.sakura,
      tertiary: tokens.accents.cyan,
      onTertiary: Colors.white,
      error: const Color(0xFFF87171),
      onError: Colors.white,
      surface: tokens.canvasBg,
      onSurface: tokens.ink,
      surfaceContainerHighest: tokens.glass.backgroundCard,
      onSurfaceVariant: tokens.inkSoft,
      outline: tokens.glass.borderColor,
    );

    // 3. 构建多维文字排版系统
    final textTheme = AppTypography.buildTextTheme(defaultColor: tokens.ink);

    // 4. 返回标准 ThemeData 并注入 ThemeExtension
    return ThemeData(
      useMaterial3: true,
      brightness: skyTheme.brightness,
      scaffoldBackgroundColor: tokens.canvasBg,
      colorScheme: colorScheme,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[tokens],

      // 追求纯粹微距手感：移除 Material 原生粗糙的墨水涟漪大扩散，采用微透明按压反馈
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,

      // 卡片统一超椭圆曲率
      cardTheme: CardThemeData(
        color: tokens.glass.backgroundCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: tokens.radii.card,
          side: BorderSide(
            color: tokens.glass.borderColor,
            width: 0.5,
          ),
        ),
      ),
    );
  }

  /// 解析三大天光专属代币实例
  static AppThemeTokens _resolveTokens(AppSkyTheme skyTheme) {
    return switch (skyTheme) {
      AppSkyTheme.dawn => const AppThemeTokens(
          skyTheme: AppSkyTheme.dawn,
          canvasBg: AppTokens.dawnCanvasBg,
          ink: AppTokens.dawnInk,
          inkSoft: AppTokens.dawnInkSoft,
          inkMuted: AppTokens.dawnInkMuted,
          skyWash: AppTokens.dawnSkyWash,
          glass: AppTokens.dawnGlass,
          radii: AppTokens.radii,
          motion: AppTokens.motion,
          accents: AppTokens.dawnAccents,
        ),
      AppSkyTheme.twilight => const AppThemeTokens(
          skyTheme: AppSkyTheme.twilight,
          canvasBg: AppTokens.twilightCanvasBg,
          ink: AppTokens.twilightInk,
          inkSoft: AppTokens.twilightInkSoft,
          inkMuted: AppTokens.twilightInkMuted,
          skyWash: AppTokens.twilightSkyWash,
          glass: AppTokens.twilightGlass,
          radii: AppTokens.radii,
          motion: AppTokens.motion,
          accents: AppTokens.twilightAccents,
        ),
      AppSkyTheme.starlight => const AppThemeTokens(
          skyTheme: AppSkyTheme.starlight,
          canvasBg: AppTokens.starlightCanvasBg,
          ink: AppTokens.starlightInk,
          inkSoft: AppTokens.starlightInkSoft,
          inkMuted: AppTokens.starlightInkMuted,
          skyWash: AppTokens.starlightSkyWash,
          glass: AppTokens.starlightGlass,
          radii: AppTokens.radii,
          motion: AppTokens.motion,
          accents: AppTokens.starlightAccents,
        ),
    };
  }
}

/// 全局 BuildContext 极简语法糖扩展
///
/// 让任意 UI Widget 均能直接以 `context.tokens.glass.background` 等方式安全访问设计代币。
extension AppThemeContext on BuildContext {
  /// 快速获取当前活跃的物理微距代币
  AppThemeTokens get tokens =>
      Theme.of(this).extension<AppThemeTokens>() ??
      AppTheme._resolveTokens(AppSkyTheme.dawn);

  /// 快速获取当前 Material ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// 快速获取全局文字排版系统
  TextTheme get textTheme => Theme.of(this).textTheme;
}
