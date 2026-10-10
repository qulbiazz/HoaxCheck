import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import 'kebijakan_shared.dart';

class KebijakanPenggunaanData extends StatelessWidget {
  const KebijakanPenggunaanData({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KebijakanSectionTitle(
          number: "3",
          title: "Penggunaan Data",
          icon: Icons.tune,
        ),
        const SizedBox(height: 12),
        KebijakanCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data dalam aplikasi digunakan secara eksklusif untuk:",
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.inverted,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),

              // 3 checklist hijau
              _buildCheckItem(
                context,
                "Menyediakan fungsionalitas deteksi teks dan verifikasi klaim hoaks.",
              ),
              const SizedBox(height: 10),
              _buildCheckItem(
                context,
                "Menampilkan rekam jejak pemeriksaan pengguna secara akurat.",
              ),
              const SizedBox(height: 10),
              _buildCheckItem(
                context,
                "Meningkatkan kenyamanan dan pengalaman interaksi pengguna.",
              ),
              const SizedBox(height: 14),

              // Info box "Komitmen Tanpa Pihak Ketiga"
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.transparent
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.block,
                      size: 16,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: isDark
                                ? AppDarkColors.textSecondary
                                : const Color(0xFF475569),
                            fontSize: 11.5,
                            height: 1.5,
                          ),
                          children: const [
                            TextSpan(
                              text: "Komitmen Tanpa Pihak Ketiga: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  "Kami tidak pernah menjual, menyewakan, atau membagikan data personal Anda kepada entitas pihak ketiga tanpa persetujuan eksplisit.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 13,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: isDark ? Colors.white70 : AppColors.inverted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}