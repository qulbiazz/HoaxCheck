import 'package:flutter/material.dart';

class OnboardingStep2Page extends StatelessWidget {
  const OnboardingStep2Page({super.key});

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
              color: const Color(0xFFE0F2FE),
            ),
            height: 260,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=800",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Icon(
                    Icons.search_rounded,
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
              color: const Color(0xFFBAE6FD).withValues(alpha: 0.7),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.auto_awesome_rounded,
                  size: 16,
                  color: Color(0xFF0284C7),
                ),
                SizedBox(width: 8),
                Text(
                  "Analisis Berbasis AI",
                  style: TextStyle(
                    color: Color(0xFF0284C7),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Verifikasi Teks, Tautan & Gambar",
            style: TextStyle(
              color: Color(0xFF151C27),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Cukup tempel teks berita, link portal, atau unggah tangkapan layar untuk mendapatkan skor validitas dan rujukan sumber terpercaya dalam hitungan detik.",
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
