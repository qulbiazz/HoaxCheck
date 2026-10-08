import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class LiteracyTipsCard extends StatelessWidget {
  const LiteracyTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              // backgroundImage: DecorationImage(...) // Tambahkan gambar ilustrasi di sini jika ada
            ),
            child: const Icon(Icons.image_outlined, color: AppColors.neutral), // Placeholder ikon
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Tips Literasi Kritis",
                  style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Periksa nama narasumber dan cek apakah judul bernada provokatif sebelum...",
                  style: TextStyle(color: AppColors.inverted, fontSize: 11, height: 1.4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}