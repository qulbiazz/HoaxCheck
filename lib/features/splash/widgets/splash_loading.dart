import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class SplashLoading extends StatelessWidget {
  final Animation<double> progressAnimation;
  final bool isDark;
  final Color primaryColor;

  const SplashLoading({
    super.key,
    required this.progressAnimation,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: progressAnimation,
          builder: (context, _) {
            return Container(
              width: 230,
              height: 6,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progressAnimation.value.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Sinkronisasi basis data fakta...',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ],
    );
  }
}