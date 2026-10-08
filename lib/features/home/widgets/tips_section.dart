import 'package:flutter/material.dart';

class TipsSection extends StatelessWidget {
  const TipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Tips Mengenali Hoaks", style: TextStyle(color: Color(0xFF1E293B), fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Panduan literasi digital sehari-hari", style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              ],
            ),
            Row(
              children: const [
                Icon(Icons.swipe, size: 14, color: Color(0xFF94A3B8)),
                SizedBox(width: 4),
                Text("Geser", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTipCard(Icons.fact_check_outlined, "Periksa sumber informasi", "Pastikan diterbitkan oleh portal berita resmi yang terverifikasi dan terdaftar di Dewan Pers.", "Tips #1", const Color(0xFFD1FAE5), const Color(0xFF059669)),
              _buildTipCard(Icons.campaign_outlined, "Waspada judul", "Jangan langsung percaya judul berita yang bombastis dan clickbait yang memicu emosi.", "Tips #2", const Color(0xFFFFE4E6), const Color(0xFFE11D48)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTipCard(IconData icon, String title, String desc, String tipNumber, Color iconBg, Color iconColor) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Color(0xFF1E293B), fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, height: 1.4)),
          const SizedBox(height: 16),
          Text(tipNumber, style: TextStyle(color: iconColor, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}