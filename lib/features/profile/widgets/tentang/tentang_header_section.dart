import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class TentangHeaderSection extends StatelessWidget {
  const TentangHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Logo (placeholder: icon di dalam lingkaran hijau)
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.verified_user,
            color: Colors.white,
            size: 44,
          ),
        ),
        const SizedBox(height: 14),

        // Badge "AI-Powered Fact Literacy"
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.auto_awesome, size: 12, color: AppColors.primary),
              SizedBox(width: 6),
              Text(
                "AI-Powered Fact Literacy",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Judul
        Text(
          "HoaxCheck",
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.inverted,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),

        // Sub-judul
        Text(
          "Bantu Kenali Informasi yang Meragukan",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark ? Colors.white70 : AppColors.inverted,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        // Deskripsi
        Text(
          "HoaxCheck adalah aplikasi yang membantu pengguna mendapatkan indikasi awal terhadap informasi yang berpotensi hoaks melalui analisis teks berbasis Machine Learning.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            fontSize: 12,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),

        // Gambar ilustrasi (placeholder)
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: isDark ? AppDarkColors.surface : const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.groups_outlined,
                size: 48,
                color: isDark ? Colors.white38 : Colors.grey.shade500,
              ),
              const SizedBox(height: 8),
              Text(
                "Ilustrasi Tim",
                style: TextStyle(
                  color: isDark ? Colors.white38 : Colors.grey.shade500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}