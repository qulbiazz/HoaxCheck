import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class LaporkanHeroCard extends StatelessWidget {
  const LaporkanHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? AppDarkColors.surface
            : AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFD1FAE5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon chat hijau
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.forum_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),

          // Konten
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul + badge
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Ada masalah?",
                        style: TextStyle(
                          color: isDark ? Colors.white : AppColors.inverted,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Bantuan",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Deskripsi
                Text(
                  "Bantu kami meningkatkan HoaxCheck dengan melaporkan masalah atau inkonsistensi data yang kamu temukan.",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : AppColors.inverted,
                    fontSize: 12,
                    height: 1.5,
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