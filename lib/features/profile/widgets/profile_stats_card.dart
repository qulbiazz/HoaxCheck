import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("STATISTIK PEMERIKSAAN", style: TextStyle(color: AppColors.neutral, fontSize: 11, fontWeight: FontWeight.bold)),
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
              _buildStatItem("48", "Total Cek", const Color(0xFFF0F5FF), const Color(0xFF2563EB)),
              const SizedBox(width: 8),
              _buildStatItem("14", "Hoaks", AppColors.danger.withOpacity(0.08), AppColors.danger),
              const SizedBox(width: 8),
              _buildStatItem("34", "Valid", AppColors.primary.withOpacity(0.15), const Color(0xFF047857)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color bgColor, Color textColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}