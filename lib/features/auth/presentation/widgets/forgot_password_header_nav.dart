import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class ForgotPasswordHeaderNav extends StatelessWidget {
  const ForgotPasswordHeaderNav({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            size: 16,
            color: isDark ? AppDarkColors.textPrimary : const Color(0xFF334155),
          ),
          label: Text(
            "Kembali",
            style: TextStyle(
              color: isDark ? AppDarkColors.textPrimary : const Color(0xFF334155),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "PEMULIHAN AKUN",
                style: TextStyle(
                  color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1D4ED8),
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}