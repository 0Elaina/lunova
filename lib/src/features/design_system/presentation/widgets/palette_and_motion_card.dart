import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/widgets.dart';

/// 灵动色彩与阻尼弹簧动力学卡片 (Palette & Motion Card)
class PaletteAndMotionCard extends StatefulWidget {
  const PaletteAndMotionCard({super.key});

  @override
  State<PaletteAndMotionCard> createState() => _PaletteAndMotionCardState();
}

class _PaletteAndMotionCardState extends State<PaletteAndMotionCard> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final accents = tokens.accents;

    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.palette,
                    size: 18,
                    color: accents.emerald,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Anime UI Craft 灵动色彩与动力学',
                    style: AppTypography.body(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: tokens.ink,
                    ),
                  ),
                ],
              ),
              // SwiftUI 级阻尼弹簧交互按钮
              AnimatedScale(
                scale: _isLiked ? 1.15 : 1.0,
                duration: tokens.motion.bounceDuration,
                curve: tokens.motion.bounceCurve,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: _isLiked
                        ? accents.sakuraLight
                        : tokens.glass.background,
                    side: BorderSide(
                      color: tokens.glass.borderColor,
                      width: 0.5,
                    ),
                  ),
                  icon: Icon(
                    LucideIcons.heart,
                    size: 18,
                    color: _isLiked ? accents.sakura : tokens.inkSoft,
                  ),
                  tooltip: '点击体验 SwiftUI 级 550ms 阻尼弹簧回弹',
                  onPressed: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 色彩阶梯
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              _ColorSwatchChip(name: 'Periwinkle', color: accents.periwinkle),
              _ColorSwatchChip(name: 'Sakura', color: accents.sakura),
              _ColorSwatchChip(name: 'Cyan', color: accents.cyan),
              _ColorSwatchChip(name: 'Purple', color: accents.purple),
              _ColorSwatchChip(name: 'Emerald', color: accents.emerald),
              _ColorSwatchChip(name: 'Amber', color: accents.amber),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorSwatchChip extends StatelessWidget {
  const _ColorSwatchChip({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: tokens.radii.inner,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            name,
            style: AppTypography.mono(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
