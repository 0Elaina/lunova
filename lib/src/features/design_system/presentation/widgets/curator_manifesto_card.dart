import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/widgets.dart';

/// 策展导言横幅卡片 (Curator's Manifesto Card)
class CuratorManifestoCard extends StatelessWidget {
  const CuratorManifestoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return GlassCard(
      borderRadius: tokens.radii.panel,
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tokens.accents.periwinkleLight,
                  borderRadius: tokens.radii.pill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.sparkle,
                      size: 12,
                      color: tokens.accents.periwinkle,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      tokens.skyTheme.description,
                      style: AppTypography.mono(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: tokens.accents.periwinkle,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'PORTABLE VAULT EDITION',
                style: AppTypography.mono(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: tokens.inkMuted,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '以光影叙事的个人图片资产管理',
            style: AppTypography.display(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: tokens.ink,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '彻底摒弃冰冷的文件列表与技术黑话。每一帧原图都珍藏在自包含便携资料库中，流经后台 Isolate 缩略图管线，在此处与晨曦、暮色与星海三套自然天光交汇。',
            style: AppTypography.body(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: tokens.inkSoft,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
