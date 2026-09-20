import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../features/shell/application/shell_provider.dart';

/// 品牌透镜无界漫射锚点 (Brand Borderless Anchor)
///
/// 100% 像素级对齐原型规范：
/// 1. 矢量绘制棱镜折射渐变月牙与星芒透镜图标 ([_BrandPrismPainter])；
/// 2. 现代 Display 骨架字 `LUN` + 同心圆光学透镜字母 `O` + `VA`；
/// 3. 日系文学双语标签：`ルノヴァ · 本地图片管理`；
/// 4. 2.6s 呼吸感祖母绿就绪微晶 ([_PulsingCrystalGem])；
/// 5. 响应式接入真实 Drift 数据库图片总数：`资料库在线就绪 · 共 X 张原画`；
/// 6. 悬停微浮起与半透明磨砂漫射反馈。
class BrandAnchor extends ConsumerStatefulWidget {
  const BrandAnchor({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  ConsumerState<BrandAnchor> createState() => _BrandAnchorState();
}

class _BrandAnchorState extends ConsumerState<BrandAnchor> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDark = tokens.skyTheme.isDark;

    // 响应式监听本地资料库真实图片总数
    final imageCountAsync = ref.watch(libraryImageCountProvider);
    final count = imageCountAsync.value ?? 0;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          // 180ms + easeOutCubic：背景淡入与微浮起同步，比 fastDuration 更有呼吸感
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          // hover 微浮起 -2px：高 DPI 屏 -1px 感知微弱，-2px 才与原型感知对齐
          transform: Matrix4.translationValues(0, _isHovered ? -2.0 : 0.0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _isHovered
                ? (isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.white.withValues(alpha: 0.50))
                : Colors.transparent,
            borderRadius: tokens.radii.pill,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. 棱镜月牙与星芒矢量透镜
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: tokens.accents.periwinkle.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomPaint(
                  size: const Size(32, 32),
                  painter: const _BrandPrismPainter(),
                ),
              ),
              const SizedBox(width: 12),

              // 2. 品牌字阶与状态堆叠
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 主标题行：LUN + 透镜O + VA + ルノヴァ · 本地图片管理
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'LUN',
                        style: AppTypography.display(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: tokens.ink,
                          letterSpacing: -0.4,
                        ),
                      ),
                      // 同心圆光学透镜字母 O
                      Container(
                        width: 13.5,
                        height: 13.5,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: tokens.accents.periwinkle,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 4.5,
                            height: 4.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tokens.accents.sakura,
                              boxShadow: [
                                BoxShadow(
                                  color: tokens.accents.sakura
                                      .withValues(alpha: 0.6),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'VA',
                        style: AppTypography.display(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: tokens.ink,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ルノヴァ · 本地图片管理',
                        style: AppTypography.body(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: tokens.inkSoft.withValues(alpha: 0.85),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  // 副标题行：呼吸绿宝石 + 实时资料库图片计数
                  Row(
                    children: [
                      const _PulsingCrystalGem(),
                      const SizedBox(width: 6),
                      Text(
                        '资料库在线就绪 · 共 $count 张原画',
                        style: AppTypography.mono(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: tokens.inkMuted,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 原型 1:1 棱镜折射渐变月牙与星芒透镜绘制器
class _BrandPrismPainter extends CustomPainter {
  const _BrandPrismPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // 缩放基准尺寸：24x24 矢量空间
    final scaleX = size.width / 24.0;
    final scaleY = size.height / 24.0;
    canvas.scale(scaleX, scaleY);

    // 1. 棱镜多色渐变弯月 (Crescent Moon Path)
    final moonPath = Path()
      ..moveTo(12, 3)
      ..cubicTo(7.02944, 3, 3, 7.02944, 3, 12)
      ..cubicTo(3, 16.9706, 7.02944, 21, 12, 21)
      ..cubicTo(13.8434, 21, 15.5583, 20.4452, 16.9859, 19.4934)
      ..cubicTo(14.0531, 18.7354, 11.8947, 16.0825, 11.8947, 12.9167)
      ..cubicTo(11.8947, 9.7508, 14.0531, 7.09796, 16.9859, 6.33999)
      ..cubicTo(15.5583, 5.38819, 13.8434, 3, 12, 3)
      ..close();

    final moonPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF5E7CE2), // periwinkle
          Color(0xFF38BDF8), // sky cyan
          Color(0xFFFF6B8B), // sakura
        ],
        stops: [0.0, 0.55, 1.0],
      ).createShader(const Rect.fromLTWH(2, 2, 20, 20))
      ..color = Colors.white.withValues(alpha: 0.92);

    canvas.drawPath(moonPath, moonPaint);

    // 2. 天蓝八角星芒 (Cyan Starburst)
    final starPath = Path()
      ..moveTo(17.5, 7.0)
      ..lineTo(18.3, 9.7)
      ..lineTo(21.0, 10.5)
      ..lineTo(18.3, 11.3)
      ..lineTo(17.5, 14.0)
      ..lineTo(16.7, 11.3)
      ..lineTo(14.0, 10.5)
      ..lineTo(16.7, 9.7)
      ..close();

    final starPaint = Paint()..color = const Color(0xFF38BDF8);
    canvas.drawPath(starPath, starPaint);

    // 3. 星芒中心纯白高光点
    final centerGlowPaint = Paint()..color = Colors.white;
    canvas.drawCircle(const Offset(17.5, 10.5), 1.1, centerGlowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 2.6s 呼吸感祖母绿就绪微晶 (Pulsing Emerald Gem)
class _PulsingCrystalGem extends StatefulWidget {
  const _PulsingCrystalGem();

  @override
  State<_PulsingCrystalGem> createState() => _PulsingCrystalGemState();
}

class _PulsingCrystalGemState extends State<_PulsingCrystalGem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2600),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.28).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const emerald = Color(0xFF10B981);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: emerald,
                boxShadow: [
                  BoxShadow(
                    color: emerald.withValues(alpha: 0.75),
                    blurRadius: 7,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
