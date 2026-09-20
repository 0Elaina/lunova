import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../gallery/application/import_notifier.dart';
import '../../application/shell_provider.dart';
import 'dock_search_bar.dart';

/// 天际通透微岛悬浮 Dock (Floating Capsule Dock)
///
/// 严格还原原型设计：
/// - 依托 [GlassCard] 药丸形态次表面磨砂容器；
/// - 包含「全部 / 收藏 / 整理」三大物理弹簧切换 Tab 与响应式数字徽标；
/// - 胶囊微型展开式搜索框；
/// - 灵动渐变「导入」动作按钮（直接打通 M2 的 [importNotifierProvider] 流水线）；
/// - 支持移动端防折行自适应排布模式。
class FloatingDock extends ConsumerWidget {
  const FloatingDock({
    super.key,
    this.isMobile = false,
  });

  /// 是否为移动端精简模式（隐藏搜索框与分割线，避免屏幕狭窄时折行）
  final bool isMobile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    final activeTab = ref.watch(shellTabProvider);
    final imageCountAsync = ref.watch(libraryImageCountProvider);
    final favCountAsync = ref.watch(favoriteImageCountProvider);
    final importState = ref.watch(importNotifierProvider);

    final totalCount = imageCountAsync.value ?? 0;
    final favCount = favCountAsync.value ?? 0;

    return GlassCard(
      borderRadius: tokens.radii.pill,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 6 : 8,
        vertical: 5,
      ),
      backgroundColor: tokens.glass.background,
      child: Row(
        mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment:
            isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          // 1. 全部画作 Tab (含总画作数 Badge)
          _DockTabButton(
            label: '全部画作',
            icon: LucideIcons.layout_grid,
            isActive: activeTab == ShellTab.all,
            badgeCount: totalCount,
            isMobile: isMobile,
            onTap: () =>
                ref.read(shellTabProvider.notifier).selectTab(ShellTab.all),
          ),
          SizedBox(width: isMobile ? 2 : 4),

          // 2. 已收藏 Tab (含已收藏数 Badge)
          _DockTabButton(
            label: '已收藏',
            icon: LucideIcons.heart,
            isActive: activeTab == ShellTab.favorites,
            badgeCount: favCount,
            isMobile: isMobile,
            onTap: () => ref
                .read(shellTabProvider.notifier)
                .selectTab(ShellTab.favorites),
          ),

          // 移动端自动精简分割线与次要部件
          if (!isMobile) ...[
            // 细微垂直分割线 1
            Container(
              width: 1,
              height: 18,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              color: tokens.inkMuted.withValues(alpha: 0.35),
            ),
          ],

          // 3. 分组与标签 Tab
          _DockTabButton(
            label: '分组与标签',
            icon: LucideIcons.tags,
            isActive: activeTab == ShellTab.organize,
            isMobile: isMobile,
            onTap: () => ref
                .read(shellTabProvider.notifier)
                .selectTab(ShellTab.organize),
          ),

          // 移动端自动隐藏次要零件
          if (!isMobile) ...[
            // 细微垂直分割线 2
            Container(
              width: 1,
              height: 18,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              color: tokens.inkMuted.withValues(alpha: 0.35),
            ),

            // 4. 展开式微型搜索框
            const DockSearchBar(),
            const SizedBox(width: 6),
          ],

          // 5. 灵动渐变导入动作按键 (+ 导入画作)
          _DockActionButton(
            isImporting: importState.isImporting,
            isMobile: isMobile,
            onTap: importState.isRunning
                ? null
                : () => ref
                    .read(importNotifierProvider.notifier)
                    .pickAndImportFiles(),
          ),
        ],
      ),
    );
  }
}

/// 单个 Dock 导航 Tab 按键 (遵循 Anime UI Craft 微浮起与阻尼按压触觉)
class _DockTabButton extends StatefulWidget {
  const _DockTabButton({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    this.badgeCount,
    this.isMobile = false,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final int? badgeCount;
  final bool isMobile;

  @override
  State<_DockTabButton> createState() => _DockTabButtonState();
}

class _DockTabButtonState extends State<_DockTabButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDark = tokens.skyTheme.isDark;

    Color backgroundColor;
    Color contentColor;
    List<BoxShadow>? shadows;

    if (widget.isActive) {
      backgroundColor = isDark ? const Color(0xFF1E293B) : Colors.white;
      contentColor = tokens.accents.periwinkle;
      shadows = [
        BoxShadow(
          color: tokens.accents.periwinkle.withValues(alpha: 0.35),
          blurRadius: 14,
          offset: const Offset(0, 4),
          spreadRadius: -2,
        ),
      ];
    } else if (_isHovered) {
      backgroundColor = isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.white.withValues(alpha: 0.55);
      contentColor = tokens.ink;
      shadows = null;
    } else {
      backgroundColor = Colors.transparent;
      contentColor = tokens.inkSoft;
      shadows = null;
    }

    final double scale = _isPressed ? 0.968 : 1.0;
    // hover 微浮起加大到 -2px，与原型 translateY(-1px) 的视觉感知更对齐
    // （原型 translateY(-1px) 是 CSS 像素，Flutter 设备像素密度更高，-2px 才有同等感知）
    final double translateY = (_isHovered && !_isPressed) ? -2.0 : 0.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          // 120ms + easeOutQuart：快速出力、柔和收尾，更接近 SwiftUI spring 阻尼感
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutQuart,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..translateByDouble(0.0, translateY, 0.0, 1.0)
            ..scaleByDouble(scale, scale, 1.0, 1.0),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 8 : 14,
            vertical: 6.5,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: tokens.radii.pill,
            boxShadow: shadows,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: widget.isMobile ? 13 : 14.5,
                color: contentColor,
              ),
              const SizedBox(width: 5),
              Text(
                widget.label,
                style: AppTypography.body(
                  fontSize: widget.isMobile ? 11 : 13,
                  fontWeight:
                      widget.isActive ? FontWeight.w700 : FontWeight.w500,
                  color: contentColor,
                ),
              ),
              if (widget.badgeCount != null) ...[
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? tokens.accents.periwinkle
                        : tokens.accents.periwinkleLight,
                    borderRadius: tokens.radii.pill,
                  ),
                  child: Text(
                    '${widget.badgeCount}',
                    style: AppTypography.mono(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color:
                          widget.isActive ? Colors.white : tokens.accents.periwinkle,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// 导入图片动作按键 (带有悬浮高光放大与 0.968x 阻尼按压微缩)
class _DockActionButton extends StatefulWidget {
  const _DockActionButton({
    required this.onTap,
    this.isImporting = false,
    this.isMobile = false,
  });

  final VoidCallback? onTap;
  final bool isImporting;
  final bool isMobile;

  @override
  State<_DockActionButton> createState() => _DockActionButtonState();
}

class _DockActionButtonState extends State<_DockActionButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final double scale = _isPressed ? 0.968 : 1.0;
    final double translateY = (_isHovered && !_isPressed) ? -1.5 : 0.0;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: tokens.motion.fastDuration,
          curve: tokens.motion.fastCurve,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..translateByDouble(0.0, translateY, 0.0, 1.0)
            ..scaleByDouble(scale, scale, 1.0, 1.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                tokens.accents.periwinkle,
                tokens.accents.cyan,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: tokens.radii.pill,
            boxShadow: [
              BoxShadow(
                color: tokens.accents.periwinkle.withValues(
                  alpha: _isHovered ? 0.60 : 0.45,
                ),
                blurRadius: _isHovered ? 18 : 14,
                offset: Offset(0, _isHovered ? 5 : 4),
                spreadRadius: -2,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 10 : 16,
            vertical: 6.5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isImporting)
                const SizedBox(
                  width: 13,
                  height: 13,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              else
                const Icon(
                  LucideIcons.plus,
                  size: 14,
                  color: Colors.white,
                ),
              const SizedBox(width: 5),
              Text(
                widget.isImporting ? '导入中...' : '导入画作',
                style: AppTypography.body(
                  fontSize: widget.isMobile ? 12 : 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
