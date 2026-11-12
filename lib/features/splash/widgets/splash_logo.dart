import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../../../../core/widgets/hoaxcheck_logo.dart'; // Sesuaikan path ini jika perlu

class SplashLogo extends StatelessWidget {
  final bool isDark;
  final Color primaryColor;

  const SplashLogo({
    super.key,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HoaxCheckLogo(
          size: 86,
          backgroundColor: primaryColor,
        ),
        const SizedBox(height: 24),
        Text(
          'HoaxCheck',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Bantu Kenali Informasi yang\nMeragukan',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            height: 1.35,
            fontWeight: FontWeight.w500,
            color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
          ),
        ),
      ],
    );
  }
}