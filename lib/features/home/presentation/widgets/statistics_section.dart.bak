import 'package:flutter/material.dart';
import 'package:hoaxcheck_app/app/theme.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Statistik Pemeriksaanmu",
              style: TextStyle(
                color: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "30 Hari Terakhir",
              style: TextStyle(color: AppColors.neutral, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KARTU 1: Total Uji
            _buildStatCard(
              title: "Total Uji",
              value: "48",
              bgColor: isDark ? AppDarkColors.surface : AppColors.surface,
              textColor: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
              bottomWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.insights, size: 14, color: AppColors.neutral),
                  SizedBox(width: 4),
                  Text(
                    "Semua\nklaim",
                    style: TextStyle(
                      color: AppColors.neutral,
                      fontSize: 11,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // KARTU 2: Hoaks
            _buildStatCard(
              title: "Hoaks",
              value: "14",
              bgColor: AppColors.danger.withOpacity(isDark ? 0.2 : 0.08),
              textColor: isDark ? const Color(0xFFFCA5A5) : AppColors.danger,
              bottomWidget: _buildBadge(
                text: "Bahaya",
                icon: Icons.warning_amber_rounded,
                textColor: isDark ? const Color(0xFFFCA5A5) : AppColors.danger,
                bgColor: AppColors.danger.withOpacity(isDark ? 0.3 : 0.15),
              ),
            ),
            const SizedBox(width: 8),

            // KARTU 3: Valid
            _buildStatCard(
              title: "Valid",
              value: "34",
              bgColor: AppColors.primary.withOpacity(isDark ? 0.2 : 0.15),
              textColor: isDark
                  ? const Color(0xFF6EE7B7)
                  : const Color(0xFF047857),
              bottomWidget: _buildBadge(
                text: "Akurat",
                icon: Icons.check_circle_outline,
                textColor: const Color(0xFF047857),
                bgColor: AppColors.primary.withOpacity(0.3),
              ),
            ),
          ],
        )
      ],
    );
  }

  // Widget builder yang diperbarui untuk menerima bottomWidget dinamis
  Widget _buildStatCard({
    required String title,
    required String value,
    required Color bgColor,
    required Color textColor,
    required Widget bottomWidget,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: (bgColor == AppColors.surface || bgColor == AppDarkColors.surface)
              ? const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))]
              : null,
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(color: textColor, fontSize: 32, fontWeight: FontWeight.bold, height: 1.0)),
            const SizedBox(height: 12),
            bottomWidget, // Widget bagian bawah dirender di sini
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat desain badge seperti pil pada kartu Hoaks & Valid
  Widget _buildBadge({
    required String text,
    required IconData icon,
    required Color textColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}