import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class AnalysisHeaderBar extends StatelessWidget {
  final String analysisId;
  final Color statusColor;

  const AnalysisHeaderBar({
    super.key,
    required this.analysisId,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "HASIL EKSTRAKSI NLP",
              style: TextStyle(
                color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? AppDarkColors.surface : const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "ID $analysisId",
            style: TextStyle(
              color: isDark ? Colors.white70 : const Color(0xFF334155),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}