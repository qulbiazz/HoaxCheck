import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        margin: const EdgeInsets.only(bottom: 2),
        width: double.infinity,
        child: Row(
          children: [
            _buildActionItem(
              title: "Tempel\nTeks",
              imageUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/5pvxgzg9_expires_30_days.png",
              marginRight: 8,
            ),
            _buildActionItem(
              title: "Masukkan\nTeks",
              imageUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/m6t7vi9s_expires_30_days.png",
              marginRight: 8,
            ),
            _buildActionItem(
              title: "Lihat\nRiwayat",
              imageUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/vcf8pqaf_expires_30_days.png",
              marginRight: 8,
            ),
            _buildActionItem(
              title: "Panduan\nDeteksi",
              imageUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/h6hitk5a_expires_30_days.png",
              marginRight: 0, // Item terakhir tidak perlu margin kanan
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem({required String title, required String imageUrl, required double marginRight}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x4DC4C5D5), width: 1),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFFFFFFF),
        ),
        // PERBAIKAN: Kurangi padding horizontal menjadi 2 agar teks punya ruang
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
        margin: EdgeInsets.only(right: marginRight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40, // Sedikit disesuaikan agar proporsional
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 6), // Jarak antara ikon dan teks
            // PERBAIKAN: Gunakan FittedBox agar teks mengecil jika kehabisan ruang
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF0B1C30),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  height: 1.2, // Mengatur jarak antar baris teks
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}