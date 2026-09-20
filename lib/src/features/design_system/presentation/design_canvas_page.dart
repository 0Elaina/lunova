import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../shared/widgets/widgets.dart';
import 'widgets/curator_manifesto_card.dart';
import 'widgets/glassmorphism_craft_card.dart';
import 'widgets/palette_and_motion_card.dart';
import 'widgets/typography_specimen_card.dart';

/// Lunova Design System 真实画卷主视口
///
/// 独立收敛于 `features/design_system/presentation/`：
/// 依托 [SkyAmbientBackdrop]、[BrandAnchor]、[SkyThemeCapsuleSwitcher] 与各独立标本卡片，
/// 提供纯粹高保真的天光漫射、0.5px 微高光、超椭圆曲率与弹簧物理实机呈现。
class DesignCanvasPage extends ConsumerWidget {
  const DesignCanvasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSky = ref.watch(skyThemeNotifierProvider);
    final tokens = context.tokens;

    return Scaffold(
      backgroundColor: tokens.canvasBg,
      body: Stack(
        children: [
          // 1. 底层：新海诚式四阶天光漫射流体介质层
          const Positioned.fill(
            child: SkyAmbientBackdrop(),
          ),

          // 2. 主视口内容区
          SafeArea(
            child: Column(
              children: [
                // 顶部无边框天际悬浮 Dock 与天光切换胶囊
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 左侧：光学透镜 Brand 锚点
                      const BrandAnchor(),

                      // 中间/右侧：三大天光切换胶囊微岛
                      SkyThemeCapsuleSwitcher(
                        currentTheme: currentSky,
                        onSelectTheme: (theme) => ref
                            .read(skyThemeNotifierProvider.notifier)
                            .setTheme(theme),
                      ),
                    ],
                  ),
                ),

                // 核心展台画卷：滚动陈列物理工艺标本
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                                'LUNOVA · ANIME UI CRAFT · DESIGN SYSTEM PHASE 1 READY',
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
