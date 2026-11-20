import 'package:flutter/material.dart';

class OnboardingStep1Page extends StatelessWidget {
  const OnboardingStep1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFE8F5E9),
            ),
            height: 260,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/bvgo0w8m_expires_30_days.png",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Icon(
                    Icons.security_rounded,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: const Color(0xFF8AF4C2).withValues(alpha: 0.6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.psychology_outlined,
                  size: 16,
                  color: Color(0xFF00714D),
                ),
                SizedBox(width: 8),
                Text(
                  "Deteksi Dini Cerdas",
                  style: TextStyle(
                    color: Color(0xFF00714D),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Kenali Informasi yang Meragukan",
            style: TextStyle(
              color: Color(0xFF151C27),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "HoaxCheck membantu kamu mendapatkan indikasi awal terhadap informasi yang berpotensi hoaks melalui pemindaian pola linguistik dan data fakta terverifikasi.",
            style: TextStyle(
              color: Color(0xFF3D4A43),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
