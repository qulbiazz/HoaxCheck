import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../detection/presentation/pages/detection_page.dart';

class GuideActionFooter extends StatelessWidget {
  const GuideActionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppDarkColors.surface : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Temukan Klaim Mencurigakan?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Uji langsung kailasi atas narasi melalui algoritma verifikasi kami.',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetectionPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Deteksi hoax lainnya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                    foregroundColor: AppColors.primary,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, size: 16),
                      SizedBox(width: 8),
                      Text('Kembali ke Daftar Panduan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Materi ini dirancang sebagai panduan edukasi literasi media publik. Rujuk Pedoman Pemberitaan Media Siber dan Kode Etik Jurnalistik resmi untuk ketentuan baku.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}