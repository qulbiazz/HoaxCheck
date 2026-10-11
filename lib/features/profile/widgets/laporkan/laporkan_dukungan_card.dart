import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class LaporkanDukunganCard extends StatelessWidget {
  const LaporkanDukunganCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppDarkColors.surface
            : AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFD1FAE5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon shield di kotak hijau
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.verified_user_outlined,
              size: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),

          // Konten
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dukungan Komunitas",
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.inverted,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "99.2% akurasi berkat umpan balik aktif pengguna.",
                  style: TextStyle(
                    color: isDark
                        ? AppDarkColors.textSecondary
                        : AppColors.neutral,
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}