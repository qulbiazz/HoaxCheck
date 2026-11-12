import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class InfoBanners extends StatelessWidget {
  const InfoBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Format Support Banner
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.15), shape: BoxShape.circle),
                child: const Icon(Icons.lightbulb_outline, color: AppColors.primary, size: 16),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Mendukung format naskah artikel, pesan broadcast WhatsApp, dan tangkapan kutipan media sosial.",
                  style: TextStyle(color: AppColors.neutral, fontSize: 11, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        
        // Methodology Notice Banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F7FF), // Biru pucat
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.verified_outlined, color: Color(0xFF2563EB), size: 16),
                  SizedBox(width: 8),
                  Text("Pemberitahuan Metodologi", style: TextStyle(color: Color(0xFF2563EB), fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "HoaxCheck memberikan indikasi awal berbasis Machine Learning dan bukan pengganti verifikasi fakta resmi lembaga pers atau otoritas berwenang.",
                style: TextStyle(color: AppColors.neutral, fontSize: 11, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}