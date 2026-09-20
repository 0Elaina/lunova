import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../core/theme/app_theme.dart';

/// 苹果级物理流体滑块主题切换器 (Apple Spring Segmented Theme Switcher)
///
/// 遵循正常桌面软件功能文案与工匠物理规范：
/// - 清晰的功能文案与标准图标：“浅色 (太阳)”、“暮色 (夕阳)”、“深色 (月亮)”；
/// - 底层为 0.5px 微高光浅磨砂超椭圆跑道槽；
/// - 选中的白金高光微药丸采用 SwiftUI Spring 阻尼在三项之间平滑滑行，手感丝滑连续；
/// - 32px 舒适高度，与窗口控制按钮形成水平轴线上的工整秩序。
class SkyThemeCapsuleSwitcher extends StatelessWidget {
  const SkyThemeCapsuleSwitcher({
    super.key,
    required this.currentTheme,
    required this.onSelectTheme,
  });

  final AppSkyTheme currentTheme;
  final ValueChanged<AppSkyTheme> onSelectTheme;

  static const double _segmentWidth = 62.0;
  static const double _segmentHeight = 26.0;
  static const double _padding = 3.0;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDark = tokens.skyTheme.isDark;

    // 当前选中的切片下标 (0: 浅色, 1: 暮色, 2: 深色)
    final selectedIndex = switch (currentTheme) {
      AppSkyTheme.dawn => 0,
      AppSkyTheme.twilight => 1,
      AppSkyTheme.starlight => 2,
    };

    return Container(
      height: _segmentHeight + (_padding * 2), // 32px
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.04),
        borderRadius: tokens.radii.pill,
        border: Border.all(
          color: tokens.glass.borderColor.withValues(alpha: isDark ? 0.3 : 0.4),
          width: 0.5,
        ),
      ),
      child: SizedBox(
        width: _segmentWidth * 3,
        height: _segmentHeight,
        child: Stack(
          children: [
            // 1. 物理流体滑块药丸 (Fluid Spring Sliding Pill)
            AnimatedPositioned(
              left: selectedIndex * _segmentWidth,
              top: 0,
              width: _segmentWidth,
              height: _segmentHeight,
              duration: tokens.motion.fastDuration,
              curve: tokens.motion.fastCurve,
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: tokens.radii.pill,
                  border: Border.all(
                    color: tokens.glass.borderColor,
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: tokens.accents.periwinkle.withValues(
                        alpha: isDark ? 0.28 : 0.22,
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                      spreadRadius: -1,
                    ),
                  ],
                ),
              ),
            ),

            // 2. 上层功能按钮文字与图标 (浅色 / 暮色 / 深色)
            Row(
              children: [
                _SegmentItem(
                  width: _segmentWidth,
                  height: _segmentHeight,
                  icon: LucideIcons.sun,
                  label: AppSkyTheme.dawn.functionalLabel,
                  isSelected: selectedIndex == 0,
                  onTap: () => onSelectTheme(AppSkyTheme.dawn),
                ),
                _SegmentItem(
                  width: _segmentWidth,
                  height: _segmentHeight,
                  icon: LucideIcons.sunset,
                  label: AppSkyTheme.twilight.functionalLabel,
                  isSelected: selectedIndex == 1,
                  onTap: () => onSelectTheme(AppSkyTheme.twilight),
                ),
                _SegmentItem(
                  width: _segmentWidth,
                  height: _segmentHeight,
                  icon: LucideIcons.moon,
                  label: AppSkyTheme.starlight.functionalLabel,
                  isSelected: selectedIndex == 2,
                  onTap: () => onSelectTheme(AppSkyTheme.starlight),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentItem extends StatefulWidget {
  const _SegmentItem({
    required this.width,
    required this.height,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final double width;
  final double height;
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_SegmentItem> createState() => _SegmentItemState();
}

class _SegmentItemState extends State<_SegmentItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    // 颜色计算：激活态强调色，未激活态悬停略亮、非悬停静柔
    final Color contentColor = widget.isSelected
        ? tokens.accents.periwinkle
        : (_isHovered ? tokens.ink : tokens.inkSoft);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 12.5,
                color: contentColor,
              ),
              const SizedBox(width: 4),
              Text(
                widget.label,
                style: AppTypography.body(
                  fontSize: 11.5,
                  fontWeight:
                      widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: contentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
