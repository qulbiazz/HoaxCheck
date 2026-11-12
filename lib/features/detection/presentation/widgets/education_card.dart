import 'package:flutter/material.dart';

class EducationCard extends StatelessWidget {
  final bool isHoax;

  const EducationCard({super.key, this.isHoax = true});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = isHoax
        ? (isDark ? const Color(0xFF7F1D1D).withValues(alpha: 0.25) : const Color(0xFFFEF2F2))
        : (isDark ? const Color(0xFF064E3B).withValues(alpha: 0.3) : const Color(0xFFECFDF5));

    final Color borderColor = isHoax
        ? (isDark ? const Color(0xFFDC2626).withValues(alpha: 0.6) : const Color(0xFFFECACA))
        : (isDark ? const Color(0xFF059669) : const Color(0xFFA7F3D0));

    final Color iconBg = isHoax ? const Color(0xFFEF4444) : const Color(0xFF10B981);
    final Color titleColor = isHoax
        ? (isDark ? Colors.white : const Color(0xFF991B1B))
        : (isDark ? Colors.white : const Color(0xFF065F46));
    final Color textColor = isHoax
        ? (isDark ? Colors.white70 : const Color(0xFFB91C1C))
        : (isDark ? Colors.white70 : const Color(0xFF047857));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Apa Artinya Hasil Ini?",
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isHoax
                      ? "Hasil ini menunjukkan bahwa model Bernoulli Naive Bayes menemukan kemunculan pola kata dan fitur teks yang konsisten dengan kumpulan data informasi hoaks. Gunakan sebagai sinyal waspada awal sebelum mempercayai atau membagikan konten."
                      : "Hasil ini menunjukkan bahwa model Bernoulli Naive Bayes mendeteksi struktur teks faktual tanpa keberadaan fitur pesan manipulasi umum. Informasi konsisten dengan pola berita/pesan valid.",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
