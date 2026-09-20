import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/window/desktop_window_service.dart';

/// 现代桌面无边框窗口控制按钮 (Modern Windows Frameless Controls)
///
/// 遵循 Windows 桌面经典人体工学与微距工匠设计：
/// - 40×32px 充足触控靶心（告别微型圆点难以点击的痛点）；
/// - 标准功能图标：水平横线 (最小化)、方框 (最大化/还原)、叉号 (关闭)；
/// - 默认状态全通透融入顶栏天光，不产生多余视觉噪点；
/// - 最小化/最大化悬停时平滑浮现半透明微高光底色；
/// - 关闭按键悬停时平滑变为醒目的 Windows 经典柔和警示红底并反白图标；
/// - 移动端平台自动安全隐藏。
class WindowControls extends StatelessWidget {
  const WindowControls({super.key});

  @override
  Widget build(BuildContext context) {
    if (!DesktopWindowService.isDesktop) {
      return const SizedBox.shrink();
    }

    // 外层去掉 glass 背景容器，三颗按钮直接裸露在天光层上
    // 各自在 hover 时才浮现背景色，默认完全透明，视觉更轻盈通透
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. 最小化 (Minimize)
        _WindowControlButton(
          icon: LucideIcons.minus,
          iconSize: 13.5,
          tooltip: '最小化',
          onTap: DesktopWindowService.minimize,
        ),

        // 2. 最大化 / 还原 (Maximize / Restore)
        _WindowControlButton(
          icon: LucideIcons.square,
          iconSize: 12,
          tooltip: '最大化 / 还原',
          onTap: DesktopWindowService.toggleMaximize,
        ),

        // 3. 关闭窗口 (Close)
        _WindowControlButton(
          icon: LucideIcons.x,
          iconSize: 14,
          tooltip: '关闭',
          isCloseAction: true,
          onTap: DesktopWindowService.close,
        ),
      ],
    );
  }
}

class _WindowControlButton extends StatefulWidget {
  const _WindowControlButton({
    required this.icon,
    required this.iconSize,
    required this.tooltip,
    required this.onTap,
    this.isCloseAction = false,
  });

  final IconData icon;
  final double iconSize;
  final String tooltip;
  final VoidCallback onTap;
  final bool isCloseAction;

  @override
  State<_WindowControlButton> createState() => _WindowControlButtonState();
}

class _WindowControlButtonState extends State<_WindowControlButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDark = tokens.skyTheme.isDark;

    Color backgroundColor;
    Color iconColor;
    List<BoxShadow>? shadows;

    if (widget.isCloseAction) {
      if (_isPressed) {
        backgroundColor = const Color(0xFFBE123C);
        iconColor = Colors.white;
        shadows = null;
      } else if (_isHovered) {
        backgroundColor = const Color(0xFFE11D48);
        iconColor = Colors.white;
        shadows = [
          BoxShadow(
            color: const Color(0xFFE11D48).withValues(alpha: 0.45),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ];
      } else {
        backgroundColor = Colors.transparent;
        iconColor = tokens.inkSoft;
        shadows = null;
      }
    } else {
      if (_isPressed) {
        backgroundColor = isDark
            ? Colors.white.withValues(alpha: 0.14)
            : Colors.black.withValues(alpha: 0.10);
        iconColor = tokens.ink;
        shadows = null;
      } else if (_isHovered) {
        backgroundColor = isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.05);
        iconColor = tokens.ink;
        shadows = null;
      } else {
        backgroundColor = Colors.transparent;
        iconColor = tokens.inkSoft;
        shadows = null;
      }
    }

    final double scale = _isPressed ? 0.95 : 1.0;

    return Tooltip(
      message: widget.tooltip,
      waitDuration: const Duration(milliseconds: 600),
      child: MouseRegion(
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
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOutCubic,
            transformAlignment: Alignment.center,
            transform: Matrix4.identity()
              ..scaleByDouble(scale, scale, 1.0, 1.0),
            width: 48,
            height: 34,
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: shadows,
            ),
            child: Center(
              child: Icon(
                widget.icon,
                size: widget.iconSize,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
