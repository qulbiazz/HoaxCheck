import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class AnalysisActionButtons extends StatelessWidget {
  final VoidCallback? onNavigateToDetection;

  const AnalysisActionButtons({super.key, this.onNavigateToDetection});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 18,
              color: isDark ? Colors.white70 : AppColors.inverted,
            ),
            label: Text(
              "Kembali",
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.inverted,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
              side: BorderSide(
                color: isDark ? Colors.transparent : const Color(0xFFCBD5E1),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
