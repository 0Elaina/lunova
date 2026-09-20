import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../gallery/data/image_repository.dart';

/// 悬浮 Dock 导航标签枚举
enum ShellTab {
  all('全部画作'),
  favorites('已收藏'),
  organize('分组与标签');

  const ShellTab(this.label);
  final String label;
}

/// 导航标签状态机 (Riverpod 3.x Notifier)
class ShellTabNotifier extends Notifier<ShellTab> {
  @override
  ShellTab build() => ShellTab.all;

  void selectTab(ShellTab tab) => state = tab;
}

/// 当前选中的 Dock 导航标签
final shellTabProvider =
    NotifierProvider<ShellTabNotifier, ShellTab>(ShellTabNotifier.new);

/// 搜索关键词状态机 (Riverpod 3.x Notifier)
class ShellSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
  void clear() => state = '';
}

/// Dock 微型搜索框输入的关键字状态
final shellSearchQueryProvider =
    NotifierProvider<ShellSearchQueryNotifier, String>(
  ShellSearchQueryNotifier.new,
);

/// 真实本地资料库图片总数响应式流 (供 BrandAnchor 与 FloatingDock 全局共享)
final libraryImageCountProvider = StreamProvider<int>((ref) {
  final imageRepo = ref.watch(imageRepositoryProvider);
  return imageRepo.watchImages().map((list) => list.length);
});

/// 真实本地资料库已收藏图片总数响应式流 (供 FloatingDock 收藏 Badge 共享)
final favoriteImageCountProvider = StreamProvider<int>((ref) {
  final imageRepo = ref.watch(imageRepositoryProvider);
  return imageRepo.watchImages(onlyFavorites: true).map((list) => list.length);
});
