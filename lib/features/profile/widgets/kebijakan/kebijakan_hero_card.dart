import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class KebijakanHeroCard extends StatelessWidget {
  const KebijakanHeroCard({super.key});

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
      child: Stack(
        children: [
          // Icon gembok besar di kanan (dekorasi)
          Positioned(
            right: -10,
            top: -10,
            child: Icon(
              Icons.lock_outline,
              size: 110,
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
          ),

          // Konten utama
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: icon + badge + waktu baca
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon shield di kotak hijau
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.security,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge + waktu baca
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Privasi Terlindungi",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.access_time,
                              size: 11,
                              color: isDark
                                  ? AppDarkColors.textSecondary
                                  : AppColors.neutral,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "3 menit baca",
                              style: TextStyle(
                                color: isDark
                                    ? AppDarkColors.textSecondary
                                    : AppColors.neutral,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Deskripsi
                        Text(
                          "Kami menghargai privasi pengguna HoaxCheck. Halaman ini menjelaskan secara ringkas bagaimana data digunakan dalam aplikasi.",
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : AppColors.inverted,
                            fontSize: 12.5,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}