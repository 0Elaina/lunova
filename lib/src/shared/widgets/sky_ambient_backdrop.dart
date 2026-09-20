import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// 新海诚式四阶天光漫射流体背景组件
///
/// 将 4 组不同色温与透明度停止点（stops: 0.0 ~ 0.7）的径向渐变锚定于视口空间：
/// - 左上主导光 (Key Light)
/// - 右下反衬暖光 (Warm Fill)
/// - 中心柔和过渡光 (Ambient)
/// - 天顶高光晕 (Accent Glow)
/// 搭配 [AppThemeTokens.motion.smoothDuration] (450ms) 实现宛若晨昏流转的平滑渐变呼吸感。
class SkyAmbientBackdrop extends StatelessWidget {
  const SkyAmbientBackdrop({super.key, this.tokens});

  final AppThemeTokens? tokens;

  @override
  Widget build(BuildContext context) {
    final activeTokens = tokens ?? context.tokens;
    final wash = activeTokens.skyWash;

    return AnimatedContainer(
      duration: activeTokens.motion.smoothDuration,
      curve: activeTokens.motion.smoothCurve,
      decoration: BoxDecoration(
        color: activeTokens.canvasBg,
      ),
      child: Stack(
        children: [
          // 1. 左上主导光 (Top-Left Key Light)
          Positioned(
            top: -120,
            left: -100,
            child: Container(
              width: 700,
              height: 550,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [wash.wash1, Colors.transparent],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),

          // 2. 右下反衬暖光 (Bottom-Right Warm Fill)
          Positioned(
            bottom: -150,
            right: -120,
            child: Container(
              width: 750,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [wash.wash3, Colors.transparent],
                  stops: const [0.0, 0.65],
                ),
              ),
            ),
          ),

          // 3. 中心柔和过渡光 (Center Ambient)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.2,
            child: Container(
              width: 500,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [wash.wash2, Colors.transparent],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),

          // 4. 天顶高光晕 (Top Accent Glow)
          Positioned(
            top: -50,
            right: 150,
            child: Container(
              width: 450,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [wash.wash4, Colors.transparent],
                  stops: const [0.0, 0.6],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
