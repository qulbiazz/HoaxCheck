import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class DetectedIndicatorsCard extends StatelessWidget {
  const DetectedIndicatorsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.fact_check_outlined,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Indikator yang Terdeteksi",
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.inverted,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E7FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "3 Pola",
                  style: TextStyle(
                    color: Color(0xFF3730A3),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildIndicatorItem(
            isDark: isDark,
            icon: Icons.campaign_outlined,
            iconBg: const Color(0xFFFEE2E2),
            iconColor: const Color(0xFFDC2626),
            title: "Bahasa Sensasional & Provokatif",
            badgeText: "Bobot Tinggi",
            badgeColor: const Color(0xFFDC2626),
            badgeBg: const Color(0xFFFEE2E2),
            desc: "Teks menggunakan ungkapan hiperbolis yang cenderung memancing kepanikan emosional pembaca.",
          ),
          const SizedBox(height: 14),
          _buildIndicatorItem(
            isDark: isDark,
            icon: Icons.forward_to_inbox_outlined,
            iconBg: const Color(0xFFE0E7FF),
            iconColor: const Color(0xFF4F46E5),
            title: "Ajakan Segera Membagikan",
            badgeText: "Bobot Sedang",
            badgeColor: const Color(0xFF2563EB),
            badgeBg: const Color(0xFFDBEAFE),
            desc: "Terdapat pola desakan untuk menyebarkan pesan ke grup lain sebelum diverifikasi ke sumber primer.",
          ),
          const SizedBox(height: 14),
          _buildIndicatorItem(
            isDark: isDark,
            icon: Icons.link_off_rounded,
            iconBg: const Color(0xFFFFEDD5),
            iconColor: const Color(0xFFEA580C),
            title: "Tautan Tidak Terverifikasi",
            badgeText: "Bobot Tinggi",
            badgeColor: const Color(0xFFDC2626),
            badgeBg: const Color(0xFFFEE2E2),
            desc: "Mencantumkan tautan domain pihak ketiga yang tidak terafiliasi dengan lembaga resmi atau pers tersertifikasi.",
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorItem({
    required bool isDark,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBg,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: isDark ? Colors.white : AppColors.inverted,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badgeText,
                            style: TextStyle(
                              color: badgeColor,
                              fontSize: 10,
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
                        color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}