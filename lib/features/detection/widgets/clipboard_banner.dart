import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class ClipboardBanner extends StatelessWidget {
  final String detectedText;
  final VoidCallback onUse;

  const ClipboardBanner({
    super.key,
    required this.detectedText,
    required this.onUse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFD6E4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.content_paste_search, color: Color(0xFF2563EB), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TEKS TERDETEKSI DI CLIPBOARD",
                  style: TextStyle(color: Color(0xFF2563EB), fontSize: 10, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "\"$detectedText\"", // Menggunakan teks dinamis
                  style: const TextStyle(color: AppColors.neutral, fontSize: 11, height: 1.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onUse, // Menjalankan fungsi dari parent saat diklik
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("Gunakan", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}