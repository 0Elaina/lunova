import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/core/window/desktop_window_service.dart';

/// Lunova 应用总入口 (Bootstrap)
///
/// 遵循企业级极简规范：仅负责平台底层绑定、全局异步异常兜底守卫与根 ProviderScope 注入。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 跨平台桌面无边框窗口底座初始化（桌面端生效，移动端安全跳过）
  await DesktopWindowService.initialize();

  // 全局异常兜底守卫（防静默崩溃）
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('全局未捕获异步异常: $error\n$stack');
    return true;
  };

  runApp(const ProviderScope(child: LunovaApp()));
}
