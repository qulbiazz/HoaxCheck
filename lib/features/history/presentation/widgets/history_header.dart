import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Riwayat", style: TextStyle(color: AppColors.inverted, fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(icon: const Icon(Icons.notifications_outlined, color: AppColors.neutral), onPressed: () {}),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        
        // Judul & Tombol Hapus
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Riwayat Pemeriksaan", style: TextStyle(color: AppColors.inverted, fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Arsip analisis teks yang pernah kamu lakukan.", style: TextStyle(color: AppColors.neutral, fontSize: 13, height: 1.4)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: AppColors.danger.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: AppColors.danger, size: 14),
                  const SizedBox(width: 4),
                  Text("Hapus", style: TextStyle(color: AppColors.danger, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // Kartu Statistik
        Row(
          children: [
            _buildStatCard("Total Cek", "48", Icons.fact_check_outlined, AppColors.inverted, AppColors.surface),
            const SizedBox(width: 8),
            _buildStatCard("Hoaks", "14", Icons.warning_amber_rounded, AppColors.danger, AppColors.surface),
            const SizedBox(width: 8),
            _buildStatCard("Valid", "34", Icons.check_circle_outline, AppColors.primary, AppColors.surface),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            Icon(icon, color: color.withOpacity(0.5), size: 18),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold, height: 1.0)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: color.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}