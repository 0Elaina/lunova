import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/widgets.dart';

/// 苹果级微距工匠物理规范实机卡片
class GlassmorphismCraftCard extends StatelessWidget {
  const GlassmorphismCraftCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return GlassCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.layers,
                size: 18,
                color: tokens.accents.periwinkle,
              ),
              const SizedBox(width: 8),
              Text(
                '苹果级微距工匠物理规范',
                style: AppTypography.body(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: tokens.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SpecRow(
            label: '倒角微高光',
            value: '0.5px Chamfer Highlight',
            color: tokens.glass.borderColor,
          ),
          _SpecRow(
            label: '高斯次表面磨砂',
            value: 'blur(${tokens.glass.blurSigma.toInt()}px) saturate(200%)',
          ),
          _SpecRow(
            label: '超椭圆连续曲率',
            value: 'Panel: 24px / Card: 16px / Inner: 10px',
          ),
          _SpecRow(
            label: '落体微反光双阴影',
            value: '${tokens.glass.shadows.length} Layers BoxShadow',
          ),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  const _SpecRow({required this.label, required this.value, this.color});

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.body(fontSize: 13, color: tokens.inkSoft),
          ),
          Row(
            children: [
              if (color != null) ...[
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400, width: 0.5),
                  ),
                ),
              ],
              Text(
                value,
                style: AppTypography.mono(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: tokens.ink,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
