import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/widgets.dart';

/// 三维多字体排版标本卡片 (Typography Specimen Card)
class TypographySpecimenCard extends StatelessWidget {
  const TypographySpecimenCard({super.key});

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
                LucideIcons.type,
                size: 18,
                color: tokens.accents.sakura,
              ),
              const SizedBox(width: 8),
              Text(
                '三维多字体排版标本',
                style: AppTypography.body(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: tokens.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Plus Jakarta Sans (Display)',
            style: AppTypography.mono(fontSize: 11, color: tokens.inkMuted),
          ),
          const SizedBox(height: 2),
          Text(
            'Light, Rhythm & Elegance 0123456789',
            style: AppTypography.display(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: tokens.ink,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Zen Maru Gothic (Body)',
            style: AppTypography.mono(fontSize: 11, color: tokens.inkMuted),
          ),
          const SizedBox(height: 2),
          Text(
            '日系治愈微圆体：给每一帧素材注入陪伴温度。',
            style: AppTypography.body(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: tokens.ink,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'JetBrains Mono (Numeric/Code)',
            style: AppTypography.mono(fontSize: 11, color: tokens.inkMuted),
          ),
          const SizedBox(height: 2),
          Text(
            'SHA-256: e3b0c44298fc... · 3840×2160 · 4.2 MB',
            style: AppTypography.mono(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: tokens.accents.periwinkle,
            ),
          ),
        ],
      ),
    );
  }
}
