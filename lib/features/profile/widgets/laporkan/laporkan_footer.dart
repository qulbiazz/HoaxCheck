import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class LaporkanFooter extends StatelessWidget {
  const LaporkanFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.lock_outline,
          size: 14,
          color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "Laporan kamu diproses secara aman untuk peningkatan berkelanjutan HoaxCheck.",
            style: TextStyle(
              color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
              fontSize: 11,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}