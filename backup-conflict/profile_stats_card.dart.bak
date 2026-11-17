import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // PERBAIKAN: Dinamis mengikuti tema
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("STATISTIK PEMERIKSAAN", style: TextStyle(color: isDark ? Colors.white54 : AppColors.neutral, fontSize: 11, fontWeight: FontWeight.bold)),
              Row(
                children: const [
                  Text("Bulan Ini", style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.primary),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // PERBAIKAN: Background transparan berdasarkan warna teks agar serasi di Dark Mode
              _buildStatItem("48", "Total Cek", isDark ? AppColors.tertiary : const Color(0xFF2563EB)),
              const SizedBox(width: 8),
              _buildStatItem("14", "Hoaks", AppColors.danger),
              const SizedBox(width: 8),
              _buildStatItem("34", "Valid", AppColors.primary),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // Dinamis
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}