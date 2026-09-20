import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

/// 跨平台桌面窗口控制服务 (Desktop Window Service)
///
/// 具备严格的跨平台条件守卫：
/// - 在桌面端（Windows / macOS / Linux）接管窗口生命周期、隐藏原生边框、实现居中与透明背景；
/// - 在移动端（Android / iOS）或 Web 端自动安全空转（No-Op），确保同一套代码无缝多端运行。
abstract final class DesktopWindowService {
  /// 是否运行在桌面端平台
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  /// 初始化无边框桌面窗口
  static Future<void> initialize() async {
    if (!isDesktop) return;

    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(1360, 860),
      minimumSize: Size(960, 640),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  /// 窗口最小化
  static Future<void> minimize() async {
    if (isDesktop) {
      await windowManager.minimize();
    }
  }

  /// 窗口最大化 / 还原切换
  static Future<void> toggleMaximize() async {
    if (!isDesktop) return;
    final isMax = await windowManager.isMaximized();
    if (isMax) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }

  /// 窗口关闭
  static Future<void> close() async {
    if (isDesktop) {
      await windowManager.close();
    }
  }
}
