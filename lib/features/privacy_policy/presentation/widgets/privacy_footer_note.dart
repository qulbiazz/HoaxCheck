import 'package:flutter/material.dart';

class PrivacyFooterNote extends StatelessWidget {
  const PrivacyFooterNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_user_outlined, size: 18, color: Color(0xFF047857)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Catatan Resmi Dokumen",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                ),
                SizedBox(height: 4),
                Text(
                  "Kebijakan ini merupakan dokumen transparansi penggunaan data layanan. Untuk pertanyaan hukum, hak cipta, atau keterbukaan algoritma, hubungi tim pengembang HoaxCheck Nusantara.",
                  style: TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}