import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import 'tentang_shared.dart';

class TentangCaraKerjaSection extends StatelessWidget {
  const TentangCaraKerjaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TentangSectionTitle(
          icon: Icons.settings_suggest_outlined,
          title: "Bagaimana Cara Kerjanya?",
        ),
        const SizedBox(height: 12),
        _buildStep(
          context,
          number: "01",
          icon: Icons.edit_note,
          title: "Masukkan Teks",
          desc:
              "Masukkan atau tempel paragraf informasi, pesan berantai, atau kutipan berita yang ingin diperiksa.",
        ),
        const SizedBox(height: 12),
        _buildStep(
          context,
          number: "02",
          icon: Icons.psychology_outlined,
          title: "Analisis Linguistik AI",
          desc:
              "Sistem menganalisis pola kalimat, sentimen ekstrim, dan karakteristik disinformasi menggunakan model Machine Learning terlatih.",
        ),
        const SizedBox(height: 12),
        _buildStep(
          context,
          number: "03",
          icon: Icons.fact_check_outlined,
          title: "Hasil & Skor Kepercayaan",
          desc:
              "HoaxCheck menampilkan hasil indikasi beserta persentase confidence score secara lugas dan transparan.",
        ),
      ],
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required String number,
    required IconData icon,
    required String title,
    required String desc,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nomor
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 14, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: isDark ? Colors.white : AppColors.inverted,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: TextStyle(
                    color:
                        isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                    fontSize: 11.5,
                    height: 1.45,
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