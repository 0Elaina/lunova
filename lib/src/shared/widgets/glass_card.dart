import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// 苹果级 0.5px 倒角微高光与次表面高斯磨砂通用容器
///
/// 严格恪守 Anime UI Craft 物理微距规范：
/// - 自动对接当前天光的 [GlassTokens] 与 [RadiusTokens]；
/// - 包含精确到 0.5 逻辑像素的倒角微高光边框；
/// - 包含外发光与落体微反光双重物理投影；
/// - 结合 [ClipRRect] 与 [BackdropFilter] 实现柔和深邃的半透明次表面散射。
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.5,
    this.shadows,
    this.blurSigma,
    this.width,
    this.height,
  });

  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? shadows;
  final double? blurSigma;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final resolvedRadius = borderRadius ?? tokens.radii.card;
    final resolvedSigma = blurSigma ?? tokens.glass.blurSigma;
    final resolvedBg = backgroundColor ?? tokens.glass.backgroundCard;
    final resolvedBorderColor = borderColor ?? tokens.glass.borderColor;
    final resolvedShadows = shadows ?? tokens.glass.shadows;

    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: resolvedBg,
        borderRadius: resolvedRadius,
        border: Border.all(
          color: resolvedBorderColor,
          width: borderWidth,
        ),
        boxShadow: resolvedShadows,
      ),
      child: child,
    );

    Widget glass = ClipRRect(
      borderRadius: resolvedRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: resolvedSigma,
          sigmaY: resolvedSigma,
        ),
        child: content,
      ),
    );

    if (margin != null) {
      glass = Padding(padding: margin!, child: glass);
    }

    return glass;
  }
}
