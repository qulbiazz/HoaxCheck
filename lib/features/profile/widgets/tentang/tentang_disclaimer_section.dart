import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class TentangDisclaimerSection extends StatelessWidget {
  const TentangDisclaimerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                "HoaxCheck merupakan alat bantu deteksi awal dan bukan alat fact-checking resmi lembaga pers. Hasil yang diberikan merupakan prediksi probabilistik model kecerdasan buatan dan tetap perlu diverifikasi ulang melalui portal berita bersertifikat Dewan Pers.",
                style: TextStyle(
                  color: isDark ? Colors.white70 : const Color(0xFF1E40AF),
                  fontSize: 11.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Footer
        Text(
          "HoaxCheck v1.0.0 (Build 2026.1)",
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Dibuat untuk Literasi Digital Indonesia",
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, size: 11, color: Color(0xFFEF4444)),
            const SizedBox(width: 6),
            Text(
              "Bersama Jaga Ruang Siber Bersih",
              style: TextStyle(
                color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}