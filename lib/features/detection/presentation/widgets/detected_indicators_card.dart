import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class DetectedIndicatorsCard extends StatelessWidget {
  final List<String> indicators;
  final bool isHoax;

  const DetectedIndicatorsCard({
    super.key,
    this.indicators = const [],
    this.isHoax = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final displayIndicators = indicators.isNotEmpty
        ? indicators
        : (isHoax
            ? [
                "Bahasa Sensasional & Provokatif",
                "Ajakan Segera Membagikan",
                "Tautan Tidak Terverifikasi",
              ]
            : [
                "Struktur Kalimat Objektif & Netral",
                "Tidak Mengandung Pola Phishing",
              ]);

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
                  Icon(
                    isHoax ? Icons.fact_check_outlined : Icons.verified_outlined,
                    size: 18,
                    color: isHoax ? const Color(0xFFDC2626) : AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isHoax ? "Indikator yang Terdeteksi" : "Indikator Validitas",
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
                  color: isHoax ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${displayIndicators.length} Pola",
                  style: TextStyle(
                    color: isHoax ? const Color(0xFFDC2626) : const Color(0xFF047857),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...displayIndicators.map((indicator) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildIndicatorItem(
                isDark: isDark,
                icon: isHoax ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                iconBg: isHoax ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5),
                iconColor: isHoax ? const Color(0xFFDC2626) : const Color(0xFF047857),
                title: indicator,
                badgeText: isHoax ? "Perhatian" : "Terverifikasi",
                badgeColor: isHoax ? const Color(0xFFDC2626) : const Color(0xFF047857),
                badgeBg: isHoax ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5),
                desc: isHoax
                    ? "Karakteristik teks ini sering ditemukan pada pesan berantai atau konten hoaks."
                    : "Pola bahasa konsisten dengan teks berita atau informasi faktual yang wajar.",
              ),
            );
          }),
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
