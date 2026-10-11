import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import 'tentang_shared.dart';

class TentangApaItuSection extends StatelessWidget {
  const TentangApaItuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TentangSectionTitle(
          icon: Icons.shield_outlined,
          title: "Apa itu HoaxCheck?",
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppDarkColors.surface : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
            ),
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
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Dirancang khusus untuk ekosistem literasi digital nusantara, HoaxCheck memadai struktur semantik, nuansa provokatif, serta konsistensi sintaksis pesan viral guna memetakan kemungkinan misinformasi secara objektif dalam hitungan detik.",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : AppColors.inverted,
                        fontSize: 12,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Expanded(
                    child: TentangInfoPill(
                      icon: Icons.speed,
                      label: "Deteksi < 3 Detik",
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TentangInfoPill(
                      icon: Icons.language,
                      label: "Fokus Bahasa Indonesia",
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
}