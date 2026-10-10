import 'package:flutter/material.dart';
import '../../pages/laporkan_masalah_page.dart';
import '../../../../app/theme.dart';

class KebijakanKontak extends StatelessWidget {
  const KebijakanKontak({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Card hijau tua
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1B5E3F),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1B5E3F).withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Ornamen lingkaran di kanan atas (dekorasi)
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon headset
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.support_agent,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Judul
                  const Text(
                    "7. Kontak & Bantuan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Deskripsi
                  Text(
                    "Punya pertanyaan seputar privasi atau pengelolaan data pribadi Anda?",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tombol putih
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LaporkanMasalahPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1B5E3F),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.mail_outline,
                            size: 16,
                            color: Color(0xFF1B5E3F),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              "Laporkan Masalah & Kontak Tim",
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: Color(0xFF1B5E3F),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Footer
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time,
              size: 11,
              color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            ),
            const SizedBox(width: 6),
            Text(
              "Terakhir diperbarui: Oktober 2026",
              style: TextStyle(
                color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "HoaxCheck v2.4.0 • Dibuat untuk ekosistem informasi bersih",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}