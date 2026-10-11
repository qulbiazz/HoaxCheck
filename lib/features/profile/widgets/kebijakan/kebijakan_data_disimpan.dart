import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import 'kebijakan_shared.dart';

class KebijakanDataDisimpan extends StatelessWidget {
  const KebijakanDataDisimpan({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KebijakanSectionTitle(
          number: "1",
          title: "Data yang Disimpan",
          icon: Icons.storage_outlined,
        ),
        const SizedBox(height: 12),
        KebijakanCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aplikasi hanya menyimpan informasi yang diperlukan untuk menjalankan fungsi aplikasi, meliputi data akun pengguna, riwayat pemeriksaan teks, hasil prediksi, serta preferensi aplikasi (seperti pengaturan tema).",
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.inverted,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),

              // Pill-pill data
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  KebijakanInfoPill(
                    icon: Icons.account_circle_outlined,
                    label: "Akun Pengguna",
                  ),
                  KebijakanInfoPill(
                    icon: Icons.history,
                    label: "Riwayat Pemeriksaan",
                  ),
                  KebijakanInfoPill(
                    icon: Icons.analytics_outlined,
                    label: "Skor Hasil",
                  ),
                  KebijakanInfoPill(
                    icon: Icons.tune,
                    label: "Preferensi",
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