import 'package:flutter/material.dart';

class RecentCheckSection extends StatelessWidget {
  const RecentCheckSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("Pemeriksaan Terakhir", style: TextStyle(color: Color(0xFF1E293B), fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 6),
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF059669), shape: BoxShape.circle)),
              ],
            ),
            const Text("Lihat Semua>", style: TextStyle(color: Color(0xFF059669), fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: const Color(0xFFDC2626)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _buildBadge("Terindikasi\nHoaks", const Color(0xFFFEE2E2), const Color(0xFFDC2626), Icons.cancel_outlined),
                                const SizedBox(width: 8),
                                _buildBadge("87%\nKeyakinan", const Color(0xFFDBEAFE), const Color(0xFF1E3A8A), null),
                              ],
                            ),
                            const Text("Hari ini, 10:42 WIB", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "\"Kemenkes bagikan subsidi suplemen gratis lewat link Telegram dengan syarat isi data NIK...\"",
                          style: TextStyle(color: Color(0xFF1E293B), fontSize: 13, height: 1.4, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.link, size: 12, color: Color(0xFF94A3B8)),
                                SizedBox(width: 4),
                                Text("Sumber: Tangkapan Layar Pesan", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                              ],
                            ),
                            Row(
                              children: const [
                                Text("Detail Analisis", style: TextStyle(color: Color(0xFF059669), fontSize: 11, fontWeight: FontWeight.bold)),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward, size: 12, color: Color(0xFF059669)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor, IconData? icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 12, color: textColor),
          if (icon != null) const SizedBox(width: 4),
          Text(text, style: TextStyle(color: textColor, fontSize: 9, fontWeight: FontWeight.bold, height: 1.1)),
        ],
      ),
    );
  }
}