import 'package:flutter/material.dart';

class PrivacySummaryCard extends StatelessWidget {
  const PrivacySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [
          BoxShadow(color: Color(0x05000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.verified_user, size: 12, color: Color(0xFF047857)),
                    SizedBox(width: 4),
                    Text(
                      "Transparansi Data Terbuka",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF047857)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.shield_outlined, color: Color(0xFF94A3B8), size: 18),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Privasi Anda Penting",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 8),
          const Text(
            "HoaxCheck menggunakan data yang diperlukan untuk menyediakan layanan deteksi awal hoaks. Pelajari data apa yang digunakan, bagaimana data dikelola, dan pilihan yang tersedia bagi Anda secara transparan.",
            style: TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeatureIcon(Icons.lock_outline, "TLS/SSL", "Enkripsi Penuh"),
              _buildFeatureIcon(Icons.visibility_off_outlined, "Anonim", "Model Training"),
              _buildFeatureIcon(Icons.block_flipped, "0 Pihak Ketiga", "Tanpa Jual Data"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF047857)),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
        Text(subtitle, style: const TextStyle(fontSize: 9, color: Color(0xFF94A3B8))),
      ],
    );
  }
}