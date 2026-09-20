import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../core/theme/app_theme.dart';
import 'glass_card.dart';

/// 三大天光切换微岛胶囊 (Sky Theme Capsule Switcher)
///
/// 依托 [GlassCard] 次表面磨砂药丸容器，提供晨曦 (Dawn)、暮色 (Twilight)、星海 (Starlight)
/// 的无缝即时切换能力。
class SkyThemeCapsuleSwitcher extends StatelessWidget {
  const SkyThemeCapsuleSwitcher({
    super.key,
    required this.currentTheme,
    required this.onSelectTheme,
  });

  final AppSkyTheme currentTheme;
  final ValueChanged<AppSkyTheme> onSelectTheme;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return GlassCard(
      borderRadius: tokens.radii.pill,
      padding: const EdgeInsets.all(4),
      backgroundColor: tokens.glass.background,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ThemePillButton(
            theme: AppSkyTheme.dawn,
            icon: LucideIcons.sun,
            isActive: currentTheme == AppSkyTheme.dawn,
            onTap: () => onSelectTheme(AppSkyTheme.dawn),
          ),
          const SizedBox(width: 4),
          _ThemePillButton(
            theme: AppSkyTheme.twilight,
            icon: LucideIcons.sunset,
            isActive: currentTheme == AppSkyTheme.twilight,
            onTap: () => onSelectTheme(AppSkyTheme.twilight),
          ),
          const SizedBox(width: 4),
          _ThemePillButton(
            theme: AppSkyTheme.starlight,
            icon: LucideIcons.sparkles,
            isActive: currentTheme == AppSkyTheme.starlight,
            onTap: () => onSelectTheme(AppSkyTheme.starlight),
          ),
        ],
      ),
    );
  }
}

class _ThemePillButton extends StatelessWidget {
  const _ThemePillButton({
    required this.theme,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final AppSkyTheme theme;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return AnimatedContainer(
      duration: tokens.motion.fastDuration,
      curve: tokens.motion.fastCurve,
      decoration: BoxDecoration(
        color: isActive
            ? (theme.isDark ? const Color(0xFF1E293B) : Colors.white)
            : Colors.transparent,
        borderRadius: tokens.radii.pill,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: tokens.accents.periwinkle.withValues(alpha: 0.28),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: tokens.radii.pill,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: isActive ? tokens.accents.periwinkle : tokens.inkSoft,
                ),
                const SizedBox(width: 6),
                Text(
                  theme.label,
                  style: AppTypography.body(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive ? tokens.accents.periwinkle : tokens.inkSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
