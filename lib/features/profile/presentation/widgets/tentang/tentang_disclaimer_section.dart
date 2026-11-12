import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class TentangDisclaimerSection extends StatelessWidget {
  final String? disclaimerText;
  final String? appVersion;

  const TentangDisclaimerSection({
    super.key,
    this.disclaimerText,
    this.appVersion,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultDisclaimer =
        "HoaxCheck merupakan alat bantu deteksi awal dan bukan alat fact-checking resmi lembaga pers. Hasil yang diberikan merupakan prediksi probabilistik model kecerdasan buatan dan tetap perlu diverifikasi ulang melalui portal berita bersertifikat Dewan Pers.";

    return Column(
      children: [
        // Disclaimer biru
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF1E3A8A).withValues(alpha: 0.25)
                : const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0xFF3B82F6) : const Color(0xFFBFDBFE),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B82F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Disclaimer & Batasan Sistem",
                    style: TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                disclaimerText ?? defaultDisclaimer,
                style: TextStyle(
                  color: isDark ? Colors.white70 : const Color(0xFF1E40AF),
                  fontSize: 11.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Versi & Lisensi
        Text(
          appVersion ?? "HoaxCheck v1.0.0",
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Pengembangan Sistem PBL 2026",
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
