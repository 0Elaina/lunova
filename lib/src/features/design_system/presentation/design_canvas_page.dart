import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'widgets/curator_manifesto_card.dart';
import 'widgets/glassmorphism_craft_card.dart';
import 'widgets/palette_and_motion_card.dart';
import 'widgets/typography_specimen_card.dart';

/// Lunova Design System 真实画卷主视口 (内容画板)
///
/// 独立收敛于 `features/design_system/presentation/`：
/// 纯粹聚焦于 4 张物理工艺与字体标本卡片的陈列展示，外层由全局 [AppShell] 统一托管
/// 天光流体、非原生无边框顶栏与天际悬浮 Dock。
class DesignCanvasPage extends StatelessWidget {
  const DesignCanvasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(28, 16, 28, 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 展台导言横幅
              const CuratorManifestoCard(),

              const SizedBox(height: 20),

              // 双栏响应式展示栅格
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 780;
                  if (isWide) {
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: GlassmorphismCraftCard()),
                        SizedBox(width: 20),
                        Expanded(child: TypographySpecimenCard()),
                      ],
                    );
                  }
                  return const Column(
                    children: [
                      GlassmorphismCraftCard(),
                      SizedBox(height: 20),
                      TypographySpecimenCard(),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              // 色彩与动力学交互展台
              const PaletteAndMotionCard(),

              const SizedBox(height: 32),

              // 底部工匠标尺与注脚
              Center(
                child: Text(
                  'LUNOVA · ANIME UI CRAFT · DESIGN SYSTEM & SHELL READY',
                  style: AppTypography.mono(
                    color: tokens.inkMuted,
                    fontSize: 11,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
