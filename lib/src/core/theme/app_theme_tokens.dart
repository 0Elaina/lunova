import 'package:flutter/material.dart';
import 'tokens.dart';

/// Lunova 物理与天光主题扩展 (ThemeExtension)
///
/// 依托 Flutter 官方标准 `ThemeExtension` 规范，将 Anime UI Craft 专属的
/// 微距高光、次表面磨砂、四阶天光流体、超椭圆曲率及弹簧物理代币无缝挂载至 `ThemeData`。
///
/// 具备完整的 `lerp` 平滑补间能力，保证在天光流转（晨曦 -> 暮色 -> 星海）时
/// 每一个颜色、阴影半径与模糊度都以毫秒级平滑过渡，无视觉跳跃与频闪。
@immutable
class AppThemeTokens extends ThemeExtension<AppThemeTokens> {
  const AppThemeTokens({
    required this.skyTheme,
    required this.canvasBg,
    required this.ink,
    required this.inkSoft,
    required this.inkMuted,
    required this.skyWash,
    required this.glass,
    required this.radii,
    required this.motion,
    required this.accents,
  });

  /// 当前所处天光类型
  final AppSkyTheme skyTheme;

  /// 画布主背景色
  final Color canvasBg;

  /// 主墨水文本色 (纯黑 / 深空亮白)
  final Color ink;

  /// 次级柔和文本色 (中灰 / 雾灰)
  final Color inkSoft;

  /// 弱化提示文本色 (浅灰 / 弱灰)
  final Color inkMuted;

  /// 四阶天光流体代币
  final SkyWashTokens skyWash;

  /// 次表面高斯磨砂与 0.5px 微高光代币
  final GlassTokens glass;

  /// 苹果级超椭圆曲率代币
  final RadiusTokens radii;

  /// SwiftUI 阻尼弹簧动力学代币
  final MotionTokens motion;

  /// 高光与强调色系
  final AccentTokens accents;

  @override
  AppThemeTokens copyWith({
    AppSkyTheme? skyTheme,
    Color? canvasBg,
    Color? ink,
    Color? inkSoft,
    Color? inkMuted,
    SkyWashTokens? skyWash,
    GlassTokens? glass,
    RadiusTokens? radii,
    MotionTokens? motion,
    AccentTokens? accents,
  }) {
    return AppThemeTokens(
      skyTheme: skyTheme ?? this.skyTheme,
      canvasBg: canvasBg ?? this.canvasBg,
      ink: ink ?? this.ink,
      inkSoft: inkSoft ?? this.inkSoft,
      inkMuted: inkMuted ?? this.inkMuted,
      skyWash: skyWash ?? this.skyWash,
      glass: glass ?? this.glass,
      radii: radii ?? this.radii,
      motion: motion ?? this.motion,
      accents: accents ?? this.accents,
    );
  }

  @override
  AppThemeTokens lerp(ThemeExtension<AppThemeTokens>? other, double t) {
    if (other is! AppThemeTokens) {
      return this;
    }

    return AppThemeTokens(
      // 离散枚举阈值切换：过半后切为目标天光
      skyTheme: t < 0.5 ? skyTheme : other.skyTheme,
      canvasBg: Color.lerp(canvasBg, other.canvasBg, t) ?? canvasBg,
      ink: Color.lerp(ink, other.ink, t) ?? ink,
      inkSoft: Color.lerp(inkSoft, other.inkSoft, t) ?? inkSoft,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t) ?? inkMuted,
      skyWash: SkyWashTokens.lerp(skyWash, other.skyWash, t),
      glass: GlassTokens.lerp(glass, other.glass, t),
      radii: RadiusTokens.lerp(radii, other.radii, t),
      motion: other.motion, // 动力学参数直接继承目标态
      accents: AccentTokens.lerp(accents, other.accents, t),
    );
  }
}
