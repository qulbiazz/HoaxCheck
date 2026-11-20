import 'package:flutter/material.dart';

class OnboardingStep3Page extends StatelessWidget {
  const OnboardingStep3Page({super.key});

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
              color: const Color(0xFFFEF3C7),
            ),
            height: 260,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=800",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Icon(
                    Icons.groups_rounded,
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
              color: const Color(0xFFFDE68A).withValues(alpha: 0.8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.verified_rounded,
                  size: 16,
                  color: Color(0xFFD97706),
                ),
                SizedBox(width: 8),
                Text(
                  "Komunitas & Kolaborasi",
                  style: TextStyle(
                    color: Color(0xFFD97706),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Ciptakan Ruang Digital yang Bersih",
            style: TextStyle(
              color: Color(0xFF151C27),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Laporkan informasi hoaks yang kamu temukan, simpan riwayat pengecekan, dan bantu masyarakat luas memilah fakta secara bijak.",
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
