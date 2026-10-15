import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Halo, siap memeriksa informasi?",
                style: TextStyle(
                  color: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Kenali informasi yang meragukan dengan lebih mudah.",
                style: TextStyle(
                  color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}