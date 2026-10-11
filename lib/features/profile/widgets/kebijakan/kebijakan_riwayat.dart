import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import 'kebijakan_shared.dart';

class KebijakanRiwayat extends StatelessWidget {
  const KebijakanRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KebijakanSectionTitle(
          number: "2",
          title: "Riwayat Pemeriksaan",
          icon: Icons.history_toggle_off,
        ),
        const SizedBox(height: 12),
        KebijakanCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Riwayat pemeriksaan digunakan untuk memungkinkan pengguna melihat kembali hasil pemeriksaan sebelumnya. Data riwayat ini hanya ditampilkan kepada Anda melalui tab menu Riwayat.",
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.inverted,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),

              // Info box biru
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E3A8A).withValues(alpha: 0.2)
                      : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFFBFDBFE),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.visibility_off_outlined,
                      size: 16,
                      color: Color(0xFF2563EB),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Data riwayat Anda bersifat privat dan tidak dapat diakses oleh publik atau pengguna lain.",
                        style: TextStyle(
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF1E40AF),
                          fontSize: 11.5,
                          height: 1.5,
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
}