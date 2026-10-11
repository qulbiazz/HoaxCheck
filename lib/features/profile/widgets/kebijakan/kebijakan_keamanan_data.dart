import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import 'kebijakan_shared.dart';

class KebijakanKeamananData extends StatelessWidget {
  const KebijakanKeamananData({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KebijakanSectionTitle(
          number: "4",
          title: "Keamanan Data",
          icon: Icons.shield_outlined,
        ),
        const SizedBox(height: 12),
        KebijakanCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kami menerapkan langkah-langkah perlindungan wajar yang dirancang untuk menjaga keamanan dan kerahasiaan data yang tersimpan di dalam perangkat dan sistem aplikasi.",
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.inverted,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),

              // 2 card kecil (Enkripsi + Akses)
              Row(
                children: [
                  Expanded(
                    child: _buildFeatureCard(
                      context,
                      icon: Icons.lock_outline,
                      title: "Enkripsi Data",
                      subtitle: "Proteksi protokol TLS/SSL",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildFeatureCard(
                      context,
                      icon: Icons.verified_user_outlined,
                      title: "Akses Terbatas",
                      subtitle: "Sistem otentikasi ketat",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E293B)
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.inverted,
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}