import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class GuideImageBanner extends StatelessWidget {
  const GuideImageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Pedoman Pers',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '• Topik 1',
              style: TextStyle(
                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Akurasi dan Verifikasi Informasi',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.access_time_rounded, size: 14, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B)),
            const SizedBox(width: 4),
            Text(
              '3 Menit Baca',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.signal_cellular_alt, size: 14, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B)),
            const SizedBox(width: 4),
            Text(
              'Tingkat: Fondasi',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey.shade300,
                child: Image.asset(
                  'assets/images/banner_panduan.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.camera_alt, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Prinsip Dasar Kualitas Nusantara',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}