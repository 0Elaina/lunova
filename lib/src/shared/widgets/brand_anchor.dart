import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../core/theme/app_theme.dart';

/// 品牌透镜无界漫射锚点 (Brand Borderless Anchor)
///
/// 严格对齐原型规范：
/// - 双色流光渐变圆环 + Lucide 星芒棱镜图标；
/// - 现代 Display 骨架字 `LUN` + 同心圆光学透镜字母 `O` + `VA`；
/// - 日系假名标签 `ルノヴァ`；
/// - 呼吸感祖母绿就绪微光晶石。
class BrandAnchor extends StatelessWidget {
  const BrandAnchor({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    Widget anchor = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 棱镜透镜图标
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [tokens.accents.periwinkle, tokens.accents.sakura],
            ),
            boxShadow: [
              BoxShadow(
                color: tokens.accents.periwinkle.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: Icon(LucideIcons.sparkles, size: 16, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'LUN',
                  style: AppTypography.display(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: tokens.ink,
                    letterSpacing: -0.5,
                  ),
                ),
                // 同心圆光学透镜字母 O
                Container(
                  width: 13,
                  height: 13,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: tokens.accents.periwinkle,
                      width: 2.2,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tokens.accents.sakura,
                      ),
                    ),
                  ),
                ),
                Text(
                  'VA',
                  style: AppTypography.display(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: tokens.ink,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'ルノヴァ',
                  style: AppTypography.body(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: tokens.inkSoft,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tokens.accents.emerald,
                    boxShadow: [
                      BoxShadow(
                        color: tokens.accents.emerald.withValues(alpha: 0.6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'DESIGN SYSTEM CRAFT',
                  style: AppTypography.mono(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: tokens.inkMuted,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    if (onTap != null) {
      anchor = InkWell(
        onTap: onTap,
        borderRadius: tokens.radii.pill,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: anchor,
        ),
      );
    }

    return anchor;
  }
}
