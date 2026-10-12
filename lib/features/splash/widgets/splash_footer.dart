import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class SplashFooter extends StatelessWidget {
  final bool isDark;
  final Color primaryColor;

  const SplashFooter({
    super.key,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.psychology_alt_outlined,
                size: 16,
                color: primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Didukung NLP & Verifikasi Publik',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppDarkColors.textPrimary : const Color(0xFF334155),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Versi 1.0.0',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }
}