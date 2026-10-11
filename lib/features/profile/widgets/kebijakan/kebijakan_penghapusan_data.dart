import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../../../../navigation/main_navigation.dart';
import 'kebijakan_shared.dart';

class KebijakanPenghapusanData extends StatelessWidget {
  const KebijakanPenghapusanData({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KebijakanSectionTitle(
          number: "5",
          title: "Penghapusan Data",
          icon: Icons.delete_outline,
        ),
        const SizedBox(height: 12),
        KebijakanCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pengguna memiliki kendali penuh atas riwayat analisis mereka. Anda dapat menghapus riwayat pemeriksaan kapan saja melalui pengaturan aplikasi dengan konfirmasi dialog pengamanan.",
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.inverted,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),

              // Tombol "Kelola riwayat di Pengaturan → Buka"
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const MainNavigation(initialIndex: 3),
                      ),
                      (route) => false,
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
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
                      children: [
                        const Icon(
                          Icons.settings_outlined,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Kelola riwayat di Pengaturan",
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white70
                                  : AppColors.inverted,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Text(
                          "Buka",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}