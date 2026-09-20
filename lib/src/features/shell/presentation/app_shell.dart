import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../../../core/theme/theme_provider.dart';
import '../../../core/window/desktop_window_service.dart';
import '../../../shared/widgets/widgets.dart';
import '../application/shell_provider.dart';
import 'widgets/floating_dock.dart';
import 'widgets/window_controls.dart';

/// Lunova 全局响应式主应用外壳 (AppShell)
///
/// 严格还原 prototype/index.html 规范与桌面人体工学：
/// 1. 只有窗口控件钉在物理窗口最右上角 (top: 0, right: 0)，甩鼠标即可盲关；
/// 2. 主题切换滑块已移入 95vw 画框内顶栏右侧 (top: 6, right: 0)，与 Brand 同一水平轴线；
/// 3. 其余整个画廊舞台 (Brand、微岛 Dock、内容视口) 严格依托 95vw / 94vh 居中悬浮画框，四周保留 28~36px 天光留白，彻底杜绝贴边！
/// 4. 四周空白天光全面覆盖 [DragToMoveArea]，点击天光空白处即可随意拖拽移动窗口或双击最大化；
/// 5. 移动端自适应：底部 14px 沉底悬浮 Dock，顶部 8px 留白。
class AppShell extends ConsumerWidget {
  const AppShell({
    super.key,
    required this.child,
  });

  /// 主舞台承载的核心视口内容 (画卷 / 瀑布流 / 展台)
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSky = ref.watch(skyThemeNotifierProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        // 移动端排布
        if (isMobile) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                const Positioned.fill(
                  child: SkyAmbientBackdrop(),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 80),
                    child: child,
                  ),
                ),
                Positioned(
                  bottom: 14,
                  left: 16,
                  right: 16,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 388),
                      child: const FloatingDock(isMobile: true),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // 桌面端排布：还原原型 95vw / 94vh 居中悬浮画框，绝不贴边！
        final shellWidth = (constraints.maxWidth * 0.95).clamp(0.0, 1540.0);
        final shellHeight = constraints.maxHeight * 0.94;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // 1. 全局最底层：全屏天光漫射流体背景
              const Positioned.fill(
                child: SkyAmbientBackdrop(),
              ),

              // 2. 全局天光可拖拽层：未被核心控件覆盖的空白天光均可自由拖拽与双击最大化
              if (DesktopWindowService.isDesktop)
                Positioned.fill(
                  child: DragToMoveArea(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onDoubleTap: DesktopWindowService.toggleMaximize,
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),

              // 3. 原型 95vw / 94vh 居中悬浮应用主外壳 (.app-shell)
              // 四周自然留出 3vh (约 30px) 顶部留白与 2.5vw (约 40px) 左右留白，彻底告别贴边！
              Center(
                child: SizedBox(
                  width: shellWidth,
                  height: shellHeight,
                  child: Stack(
                    children: [
                      // (1) 主画廊内容视口：顶部避让 64px (微岛高 40px + 24px 留白)，首张卡片与微岛拉开舒展间隙
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 64, bottom: 20),
                          child: child,
                        ),
                      ),

                      // (1.5) 幽灵水印大字装饰层：原型 .ghost-watermark-text 还原
                      // 位于内容区顶部 (top: 64+15=79)，水平居中，纯描边轮廓字，pointer-events none
                      Positioned(
                        top: 79,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GhostWatermark(
                            text: switch (ref.watch(shellTabProvider)) {
                              ShellTab.all => 'GALLERY',
                              ShellTab.favorites => 'FAVORITES',
                              ShellTab.organize => 'ORGANIZE',
                            },
                          ),
                        ),
                      ),

                      // (2) 左上角 Brand 品牌锚点：位于画框内左上角 (top: 6, left: 16)，随画框内缩，绝不贴物理屏幕边缘！
                      const Positioned(
                        top: 6,
                        left: 16,
                        child: BrandAnchor(),
                      ),

                      // (3) 天际微岛悬浮 Dock：位于画框内中上部 (top: 6)，水平居中
                      Positioned(
                        top: 6,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 880),
                            child: const FloatingDock(isMobile: false),
                          ),
                        ),
                      ),

                      // (4) 主题切换器：移入画框内顶栏右侧 (top: 14, right: 0)，略低于 Brand/Dock
                      // 不再钉在物理窗口侧，随画框内缩，与右侧天光留白呼应
                      if (DesktopWindowService.isDesktop)
                        Positioned(
                          top: 14,
                          right: 0,
                          child: SkyThemeCapsuleSwitcher(
                            currentTheme: currentSky,
                            onSelectTheme: (theme) => ref
                                .read(skyThemeNotifierProvider.notifier)
                                .setTheme(theme),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // 4. 只有窗口控件独立钉在物理最右上角！
              // 甩鼠标直接盲关，绝不随 95vw 画框内缩；主题切换器已移入画框内
              if (DesktopWindowService.isDesktop)
                const Positioned(
                  top: 0,
                  right: 0,
                  child: WindowControls(),
                ),
            ],
          ),
        );
      },
    );
  }
}
