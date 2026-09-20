import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../application/shell_provider.dart';

/// 胶囊内微型展开式搜索框 (Dock Micro Search Bar)
///
/// 严格还原原型设计：
/// - 默认状态：收敛宽度约 115px，极简融入 Dock；
/// - 获取焦点（Focus）：触发 [AppThemeTokens.motion.fastDuration] 弹性展开至 175px，
///   并带有 3px `accent-periwinkle-light` 外扩散柔和焦点环；
/// - 输入内容时提供一键清除微按键；
/// - 状态与 [shellSearchQueryProvider] 实时双向打通。
class DockSearchBar extends ConsumerStatefulWidget {
  const DockSearchBar({super.key});

  @override
  ConsumerState<DockSearchBar> createState() => _DockSearchBarState();
}

class _DockSearchBarState extends ConsumerState<DockSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDark = tokens.skyTheme.isDark;

    return AnimatedContainer(
      // spring-fast 对应：cubic-bezier(0.32, 0.72, 0, 1)，200ms 弹出快而收尾柔
      duration: const Duration(milliseconds: 200),
      curve: const Cubic(0.32, 0.72, 0, 1),
      width: _isFocused ? 170 : 110,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _isFocused
            ? (isDark ? const Color(0xFF0F172A) : Colors.white)
            : (isDark
                ? const Color(0xFF0F172A).withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.55)),
        borderRadius: tokens.radii.pill,
        border: Border.all(
          color: _isFocused
              ? tokens.accents.periwinkle
              : tokens.glass.borderColor.withValues(alpha: 0.7),
          width: _isFocused ? 1.0 : 0.5,
        ),
        // 对焦光环：0px blur + 3px spread → 精确还原原型 box-shadow: 0 0 0 3px periwinkleLight
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: tokens.accents.periwinkle.withValues(alpha: 0.16),
                  blurRadius: 0,
                  spreadRadius: 3,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Icon(
            LucideIcons.search,
            size: 13,
            color: _isFocused ? tokens.accents.periwinkle : tokens.inkMuted,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (val) {
                ref.read(shellSearchQueryProvider.notifier).setQuery(val);
              },
              style: AppTypography.body(
                fontSize: 12,
                color: tokens.ink,
              ),
              cursorColor: tokens.accents.periwinkle,
              decoration: InputDecoration(
                hintText: '搜索原画、标签...',
                hintStyle: AppTypography.body(
                  fontSize: 12,
                  color: tokens.inkMuted,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                ref.read(shellSearchQueryProvider.notifier).clear();
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  LucideIcons.x,
                  size: 12,
                  color: tokens.inkMuted,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
