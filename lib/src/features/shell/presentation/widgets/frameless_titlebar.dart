import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../../../core/window/desktop_window_service.dart';
import '../../../../shared/widgets/widgets.dart';
import 'window_controls.dart';

/// 桌面端非原生无边框顶栏 (Frameless Titlebar)
///
/// 还原专业桌面人体工学与二次元通透天际线：
/// - 左侧：Brand 锚点 (距左边缘 20px)；
/// - 中间：全透光 [DragToMoveArea] 窗口拖拽区，支持双击最大化/还原；
/// - 右侧：主题流体切换器右移至副操作区，与窗口控制留出 16px 呼吸空隙；
/// - 极右上角：窗口控制按键直接靠齐物理窗口最右上边缘 (无多余冗余边距，甩鼠标即可盲关)。
class FramelessTitlebar extends ConsumerWidget {
  const FramelessTitlebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSky = ref.watch(skyThemeNotifierProvider);

    return SizedBox(
      height: 54,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 0),
        child: Row(
          children: [
            // 1. 左侧：品牌透镜锚点
            const BrandAnchor(),

            // 2. 中间：全透光拖拽区域 (双击切换最大化)
            Expanded(
              child: DesktopWindowService.isDesktop
                  ? DragToMoveArea(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onDoubleTap: DesktopWindowService.toggleMaximize,
                        child: const SizedBox.expand(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            // 3. 右侧：主题流体切换滑块 (右移至此)
            SkyThemeCapsuleSwitcher(
              currentTheme: currentSky,
              onSelectTheme: (theme) => ref
                  .read(skyThemeNotifierProvider.notifier)
                  .setTheme(theme),
            ),

            // 4. 物理最右上角：窗口控制按键 (移动端自动隐藏)
            if (DesktopWindowService.isDesktop) ...[
              const SizedBox(width: 16),
              const WindowControls(),
            ],
          ],
        ),
      ),
    );
  }
}
