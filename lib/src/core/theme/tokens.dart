import 'dart:ui';
import 'package:flutter/material.dart';

/// Lunova 三大核心天光枚举
///
/// 对应 Anime UI Craft 原型中的三种自然光色介质：
/// - [dawn]: 晨曦（清透水蓝与微粉漫射，清新治愈）
/// - [twilight]: 暮色（暮光微醺紫粉橙金，温暖绮丽）
/// - [starlight]: 星海（深空幽蓝与星芒，暗夜沉浸）
enum AppSkyTheme {
  dawn('晨曦天光', '清澈水蓝与晨樱微温', Brightness.light),
  twilight('暮色微醺', '落日紫粉与薄暮霞彩', Brightness.light),
  starlight('星海深空', '深蓝夜幕与银河冷星', Brightness.dark);

  const AppSkyTheme(this.label, this.description, this.brightness);

  final String label;
  final String description;
  final Brightness brightness;

  bool get isDark => brightness == Brightness.dark;
}

/// 四阶天光漫射色阶代币 (4-Stop Ambient Sky Wash)
///
/// 还原新海诚式晨曦/暮色天空漫射：由 4 个特定角度与范围的径向渐变混合而成。
@immutable
class SkyWashTokens {
  const SkyWashTokens({
    required this.wash1,
    required this.wash2,
    required this.wash3,
    required this.wash4,
  });

  /// 左上主导光 (Top-Left Key Light)
  final Color wash1;

  /// 中心漫射光 (Center Ambient)
  final Color wash2;

  /// 右下反衬光 (Bottom-Right Warm Fill)
  final Color wash3;

  /// 顶层高光晕 (Top Accent Glow)
  final Color wash4;

  SkyWashTokens copyWith({
    Color? wash1,
    Color? wash2,
    Color? wash3,
    Color? wash4,
  }) {
    return SkyWashTokens(
      wash1: wash1 ?? this.wash1,
      wash2: wash2 ?? this.wash2,
      wash3: wash3 ?? this.wash3,
      wash4: wash4 ?? this.wash4,
    );
  }

  static SkyWashTokens lerp(SkyWashTokens? a, SkyWashTokens? b, double t) {
    if (identical(a, b) && a != null) return a;
    return SkyWashTokens(
      wash1: Color.lerp(a?.wash1, b?.wash1, t) ?? Colors.transparent,
      wash2: Color.lerp(a?.wash2, b?.wash2, t) ?? Colors.transparent,
      wash3: Color.lerp(a?.wash3, b?.wash3, t) ?? Colors.transparent,
      wash4: Color.lerp(a?.wash4, b?.wash4, t) ?? Colors.transparent,
    );
  }
}

/// 苹果级次表面高斯磨砂与 0.5px 微高光代币 (Subsurface Glass Tokens)
@immutable
class GlassTokens {
  const GlassTokens({
    required this.background,
    required this.backgroundHover,
    required this.backgroundCard,
    required this.borderColor,
    required this.highlightInnerColor,
    required this.blurSigma,
    required this.shadows,
  });

  /// 默认毛玻璃容器底色（如悬浮 Dock、操作胶囊）
  final Color background;

  /// 悬停/激活动态底色
  final Color backgroundHover;

  /// 展台/卡片主容器底色
  final Color backgroundCard;

  /// 0.5px 倒角微高光边框色
  final Color borderColor;

  /// 模拟内侧微高光线条色（对应原型中 inset 0 1px 0 0 高光反射）
  final Color highlightInnerColor;

  /// 高斯模糊强度（标准 28px 换算为 Flutter 渲染管线的 sigma）
  final double blurSigma;

  /// 物理投影序列（包含外发光与柔和落体阴影）
  final List<BoxShadow> shadows;

  GlassTokens copyWith({
    Color? background,
    Color? backgroundHover,
    Color? backgroundCard,
    Color? borderColor,
    Color? highlightInnerColor,
    double? blurSigma,
    List<BoxShadow>? shadows,
  }) {
    return GlassTokens(
      background: background ?? this.background,
      backgroundHover: backgroundHover ?? this.backgroundHover,
      backgroundCard: backgroundCard ?? this.backgroundCard,
      borderColor: borderColor ?? this.borderColor,
      highlightInnerColor: highlightInnerColor ?? this.highlightInnerColor,
      blurSigma: blurSigma ?? this.blurSigma,
      shadows: shadows ?? this.shadows,
    );
  }

  static GlassTokens lerp(GlassTokens? a, GlassTokens? b, double t) {
    if (identical(a, b) && a != null) return a;
    return GlassTokens(
      background: Color.lerp(a?.background, b?.background, t) ?? Colors.transparent,
      backgroundHover: Color.lerp(a?.backgroundHover, b?.backgroundHover, t) ?? Colors.transparent,
      backgroundCard: Color.lerp(a?.backgroundCard, b?.backgroundCard, t) ?? Colors.transparent,
      borderColor: Color.lerp(a?.borderColor, b?.borderColor, t) ?? Colors.transparent,
      highlightInnerColor: Color.lerp(a?.highlightInnerColor, b?.highlightInnerColor, t) ?? Colors.transparent,
      blurSigma: lerpDouble(a?.blurSigma, b?.blurSigma, t) ?? 16.0,
      shadows: BoxShadow.lerpList(a?.shadows, b?.shadows, t) ?? const [],
    );
  }
}

/// 苹果级超椭圆连续曲率代币 (Super-ellipse Radius Tokens)
///
/// 还原 iOS/macOS 纯正的物理曲率手感，规避普通圆角的割裂感。
@immutable
class RadiusTokens {
  const RadiusTokens({
    this.pill = const BorderRadius.all(Radius.circular(9999)),
    this.panel = const BorderRadius.all(Radius.circular(24)),
    this.card = const BorderRadius.all(Radius.circular(16)),
    this.inner = const BorderRadius.all(Radius.circular(10)),
  });

  /// 药丸胶囊状（悬浮 Dock、状态标签、按键）
  final BorderRadius pill;

  /// 大面板/展台（Hero Showcase Panel）
  final BorderRadius panel;

  /// 媒体卡片/瀑布流卡片（Image Grid Card）
  final BorderRadius card;

  /// 内部嵌套小微件（Swatch、Inner Tag）
  final BorderRadius inner;

  static RadiusTokens lerp(RadiusTokens? a, RadiusTokens? b, double t) {
    if (identical(a, b) && a != null) return a;
    return RadiusTokens(
      pill: BorderRadius.lerp(a?.pill, b?.pill, t) ?? const BorderRadius.all(Radius.circular(9999)),
      panel: BorderRadius.lerp(a?.panel, b?.panel, t) ?? const BorderRadius.all(Radius.circular(24)),
      card: BorderRadius.lerp(a?.card, b?.card, t) ?? const BorderRadius.all(Radius.circular(16)),
      inner: BorderRadius.lerp(a?.inner, b?.inner, t) ?? const BorderRadius.all(Radius.circular(10)),
    );
  }
}

/// SwiftUI 级阻尼弹簧动力学代币 (Spring Motion Tokens)
@immutable
class MotionTokens {
  const MotionTokens({
    this.fastDuration = const Duration(milliseconds: 220),
    this.smoothDuration = const Duration(milliseconds: 450),
    this.bounceDuration = const Duration(milliseconds: 550),
    this.fastCurve = const Cubic(0.32, 0.72, 0.0, 1.0),
    this.smoothCurve = const Cubic(0.16, 1.0, 0.3, 1.0),
    this.bounceCurve = const Cubic(0.175, 0.885, 0.32, 1.275),
  });

  /// 敏捷响应（按钮悬停、Tab 按压）：220ms
  final Duration fastDuration;

  /// 平滑展开（面板展开、天光渐变切换）：450ms
  final Duration smoothDuration;

  /// 弹性回弹（徽标点赞、胶囊吸附）：550ms
  final Duration bounceDuration;

  /// 快速加速曲线 cubic-bezier(0.32, 0.72, 0, 1)
  final Curve fastCurve;

  /// 自然阻尼曲线 cubic-bezier(0.16, 1, 0.3, 1)
  final Curve smoothCurve;

  /// 弹簧反弹曲线 cubic-bezier(0.175, 0.885, 0.32, 1.275)
  final Curve bounceCurve;
}

/// Anime UI Craft 强调色系代币
@immutable
class AccentTokens {
  const AccentTokens({
    required this.periwinkle,
    required this.periwinkleLight,
    required this.sakura,
    required this.sakuraLight,
    required this.cyan,
    required this.purple,
    required this.emerald,
    required this.amber,
  });

  final Color periwinkle;
  final Color periwinkleLight;
  final Color sakura;
  final Color sakuraLight;
  final Color cyan;
  final Color purple;
  final Color emerald;
  final Color amber;

  static AccentTokens lerp(AccentTokens? a, AccentTokens? b, double t) {
    if (identical(a, b) && a != null) return a;
    return AccentTokens(
      periwinkle: Color.lerp(a?.periwinkle, b?.periwinkle, t) ?? Colors.blue,
      periwinkleLight: Color.lerp(a?.periwinkleLight, b?.periwinkleLight, t) ?? Colors.transparent,
      sakura: Color.lerp(a?.sakura, b?.sakura, t) ?? Colors.pink,
      sakuraLight: Color.lerp(a?.sakuraLight, b?.sakuraLight, t) ?? Colors.transparent,
      cyan: Color.lerp(a?.cyan, b?.cyan, t) ?? Colors.cyan,
      purple: Color.lerp(a?.purple, b?.purple, t) ?? Colors.purple,
      emerald: Color.lerp(a?.emerald, b?.emerald, t) ?? Colors.green,
      amber: Color.lerp(a?.amber, b?.amber, t) ?? Colors.amber,
    );
  }
}

/// 预置三大天光物理代币常量库
abstract final class AppTokens {
  // ---------------------------------------------------------------------------
  // 1. 晨曦天光 Dawn (Default Light)
  // ---------------------------------------------------------------------------
  static const dawnCanvasBg = Color(0xFFF3F6FC);
  static const dawnInk = Color(0xFF0F172A);
  static const dawnInkSoft = Color(0xFF475569);
  static const dawnInkMuted = Color(0xFF94A3B8);

  static const dawnSkyWash = SkyWashTokens(
    wash1: Color(0x737DC3FA), // rgba(125, 195, 250, 0.45)
    wash2: Color(0x6693C5FD), // rgba(147, 197, 253, 0.40)
    wash3: Color(0x8CFECDE1), // rgba(254, 205, 225, 0.55)
    wash4: Color(0x59FEF08A), // rgba(254, 240, 138, 0.35)
  );

  static const dawnGlass = GlassTokens(
    background: Color(0xB8FFFFFF),      // rgba(255, 255, 255, 0.72)
    backgroundHover: Color(0xE6FFFFFF), // rgba(255, 255, 255, 0.90)
    backgroundCard: Color(0xD1FFFFFF),  // rgba(255, 255, 255, 0.82)
    borderColor: Color(0xEBFFFFFF),     // rgba(255, 255, 255, 0.92)
    highlightInnerColor: Color(0xF2FFFFFF), // rgba(255, 255, 255, 0.95)
    blurSigma: 16.0,
    shadows: [
      BoxShadow(
        color: Color(0x295E7CE2), // rgba(94, 124, 226, 0.16)
        blurRadius: 36,
        offset: Offset(0, 16),
        spreadRadius: -6,
      ),
      BoxShadow(
        color: Color(0x0F64748B), // rgba(100, 116, 139, 0.06)
        blurRadius: 14,
        offset: Offset(0, 4),
        spreadRadius: -2,
      ),
    ],
  );

  static const dawnAccents = AccentTokens(
    periwinkle: Color(0xFF5E7CE2),
    periwinkleLight: Color(0x295E7CE2), // rgba(94, 124, 226, 0.16)
    sakura: Color(0xFFFF6B8B),
    sakuraLight: Color(0x29FF6B8B),     // rgba(255, 107, 139, 0.16)
    cyan: Color(0xFF0284C7),
    purple: Color(0xFF8B5CF6),
    emerald: Color(0xFF10B981),
    amber: Color(0xFFF59E0B),
  );

  // ---------------------------------------------------------------------------
  // 2. 暮色微醺 Twilight (Warm Light)
  // ---------------------------------------------------------------------------
  static const twilightCanvasBg = Color(0xFFF8F4F9);
  static const twilightInk = Color(0xFF180D24);
  static const twilightInkSoft = Color(0xFF5B466B);
  static const twilightInkMuted = Color(0xFF94A3B8);

  static const twilightSkyWash = SkyWashTokens(
    wash1: Color(0x66A855F7), // rgba(168, 85, 247, 0.40)
    wash2: Color(0x5CEC4899), // rgba(236, 72, 153, 0.36)
    wash3: Color(0x61F97316), // rgba(249, 115, 22, 0.38)
    wash4: Color(0x47FDE047), // rgba(253, 224, 71, 0.28)
  );

  static const twilightGlass = GlassTokens(
    background: Color(0xBAFFFFFF),
    backgroundHover: Color(0xEBFFFFFF),
    backgroundCard: Color(0xD4FFFFFF),
    borderColor: Color(0xEBFFFFFF),
    highlightInnerColor: Color(0xF2FFFFFF),
    blurSigma: 16.0,
    shadows: [
      BoxShadow(
        color: Color(0x2E8B5CF6),
        blurRadius: 36,
        offset: Offset(0, 16),
        spreadRadius: -6,
      ),
      BoxShadow(
        color: Color(0x0F64748B),
        blurRadius: 14,
        offset: Offset(0, 4),
        spreadRadius: -2,
      ),
    ],
  );

  static const twilightAccents = AccentTokens(
    periwinkle: Color(0xFFA855F7),     // 暮色偏向晚霞紫
    periwinkleLight: Color(0x29A855F7),
    sakura: Color(0xFFFF6B8B),
    sakuraLight: Color(0x29FF6B8B),
    cyan: Color(0xFF0284C7),
    purple: Color(0xFF8B5CF6),
    emerald: Color(0xFF10B981),
    amber: Color(0xFFF59E0B),
  );

  // ---------------------------------------------------------------------------
  // 3. 星海深空 Starlight (Dark Mode)
  // ---------------------------------------------------------------------------
  static const starlightCanvasBg = Color(0xFF0C1024);
  static const starlightInk = Color(0xFFF8FAFC);
  static const starlightInkSoft = Color(0xFF94A3B8);
  static const starlightInkMuted = Color(0xFF64748B);

  static const starlightSkyWash = SkyWashTokens(
    wash1: Color(0x3838BDF8), // rgba(56, 189, 248, 0.22)
    wash2: Color(0x406366F1), // rgba(99, 102, 241, 0.25)
    wash3: Color(0x40A855F7), // rgba(168, 85, 247, 0.25)
    wash4: Color(0xD90F172A), // rgba(15, 23, 42, 0.85)
  );

  static const starlightGlass = GlassTokens(
    background: Color(0xC7161C38),      // rgba(22, 28, 56, 0.78)
    backgroundHover: Color(0xE61E294E), // rgba(30, 41, 78, 0.90)
    backgroundCard: Color(0xB8131833),  // 深空卡片底色
    borderColor: Color(0x3893C5FD),     // rgba(147, 197, 253, 0.22)
    highlightInnerColor: Color(0x40FFFFFF), // 柔和高光边缘
    blurSigma: 20.0,
    shadows: [
      BoxShadow(
        color: Color(0xA6030514), // rgba(3, 5, 20, 0.65)
        blurRadius: 48,
        offset: Offset(0, 20),
        spreadRadius: -6,
      ),
    ],
  );

  static const starlightAccents = AccentTokens(
    periwinkle: Color(0xFF38BDF8),     // 星海偏向天青光
    periwinkleLight: Color(0x2938BDF8),
    sakura: Color(0xFFFF6B8B),
    sakuraLight: Color(0x29FF6B8B),
    cyan: Color(0xFF0284C7),
    purple: Color(0xFF8B5CF6),
    emerald: Color(0xFF10B981),
    amber: Color(0xFFF59E0B),
  );

  // ---------------------------------------------------------------------------
  // 通用几何与动力学规范
  // ---------------------------------------------------------------------------
  static const radii = RadiusTokens();
  static const motion = MotionTokens();
}
