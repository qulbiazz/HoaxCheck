import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

// --- QUICK ACTIONS ---
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Aksi Cepat", style: TextStyle(color: AppColors.inverted, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildActionCard(Icons.paste, "Tempel Teks", "Analisis cepat", AppColors.primary)),
            const SizedBox(width: 12),
            Expanded(child: _buildActionCard(Icons.edit_note, "Ketik Manual", "Tulis klaim", AppColors.tertiary)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildActionCard(Icons.history, "Lihat Riwayat", "Jejak verifikasi", AppColors.neutral)),
            const SizedBox(width: 12),
            Expanded(child: _buildActionCard(Icons.menu_book, "Panduan", "Pedoman Pers", AppColors.primary)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(IconData icon, String title, String subtitle, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: AppColors.inverted, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppColors.neutral, fontSize: 11)),
        ],
      ),
    );
  }
}