import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_theme.dart';

/// 远景幽灵大文字水印 (Ghost Outline Typography Watermark)
///
/// 严格还原原型 `.ghost-watermark-text` 规范：
/// - `color: transparent` + `foreground Paint(style: stroke)` → 只有描边轮廓，无填充；
/// - 描边颜色：`periwinkle.withOpacity(0.12)`（晨曦/暮色）或 `skyBlue.withOpacity(0.08)`（星海）；
/// - 字号响应式：`clamp(56px, 8vw, 120px)`，与原型 `clamp(3.5rem, 8vw, 7.5rem)` 对齐；
/// - 字体：Plus Jakarta Sans 900（Display 骨架字）；
/// - 字距：`0.15em` 宽松轨道；
/// - 完全 `pointer-events: none`，纯装饰层，不拦截任何点击。
class GhostWatermark extends StatelessWidget {
  const GhostWatermark({
    super.key,
    this.text = 'GALLERY',
  });

  /// 水印文字内容，默认为「GALLERY」
  final String text;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDark = tokens.skyTheme.isDark;

    // 响应式字号：clamp(56, 8% of viewport width, 120)
    final viewportWidth = MediaQuery.sizeOf(context).width;
    final fontSize = (viewportWidth * 0.08).clamp(56.0, 120.0);

    // 描边颜色：晨曦/暮色用 periwinkle 0.12，星海深空用天蓝 0.08
    final strokeColor = isDark
        ? const Color(0xFF93C5FD).withValues(alpha: 0.08) // 星海：sky-300 低调
        : tokens.accents.periwinkle.withValues(alpha: 0.12); // 晨曦/暮色：periwinkle 轻描

    // foreground Paint：只描边，不填充，1.5px 细轮廓
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = strokeColor;

    return IgnorePointer(
      // 纯装饰层，完全不拦截点击与鼠标事件
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.visible, // 允许字形轮廓横向溢出，不被裁剪
            style: GoogleFonts.plusJakartaSans(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              letterSpacing: fontSize * 0.12, // 0.12em 字距，略收一点避免过度拉伸
              foreground: strokePaint,
              height: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}
