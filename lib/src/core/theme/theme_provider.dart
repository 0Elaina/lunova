import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart';

/// 全局天光主题状态机 (Riverpod 3.x Notifier)
///
/// 管理 Lunova 的三种动态自然天光模式（晨曦 Dawn、暮色 Twilight、星海 Starlight）。
class SkyThemeNotifier extends Notifier<AppSkyTheme> {
  @override
  AppSkyTheme build() {
    // 默认开启新海诚晨曦天光 (Dawn)
    return AppSkyTheme.dawn;
  }

  /// 明确切换到指定天光
  void setTheme(AppSkyTheme theme) {
    if (state != theme) {
      state = theme;
    }
  }

  /// 循环切换到下一个天光 (晨曦 -> 暮色 -> 星海 -> 晨曦)
  void cycleNext() {
    final nextIndex = (state.index + 1) % AppSkyTheme.values.length;
    state = AppSkyTheme.values[nextIndex];
  }
}

/// 天光模式状态提供者
final skyThemeNotifierProvider =
    NotifierProvider<SkyThemeNotifier, AppSkyTheme>(SkyThemeNotifier.new);

/// 当前装配就绪的全局 ThemeData 提供者
///
/// 当 [skyThemeNotifierProvider] 发生变动时，自动驱动根 MaterialApp 进行主题平滑重绘。
final currentThemeProvider = Provider<ThemeData>((ref) {
  final skyTheme = ref.watch(skyThemeNotifierProvider);
  return AppTheme.buildTheme(skyTheme);
});
