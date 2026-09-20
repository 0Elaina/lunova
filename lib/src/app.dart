import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/theme_provider.dart';
import 'features/design_system/presentation/design_canvas_page.dart';
import 'features/shell/presentation/app_shell.dart';

/// Lunova 根应用组件 (Root Application)
///
/// 职责：
/// 1. 响应式监听全局 [currentThemeProvider]，驱动多天光主题平滑重绘；
/// 2. 配置应用基础元数据、全局导航路由与主应用外壳 (AppShell) 挂载。
class LunovaApp extends ConsumerWidget {
  const LunovaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(currentThemeProvider);

    return MaterialApp(
      title: 'Lunova · 资产管理',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const AppShell(
        child: DesignCanvasPage(),
      ),
    );
  }
}
