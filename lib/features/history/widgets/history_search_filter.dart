import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class HistorySearchFilter extends StatelessWidget {
  const HistorySearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: const TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search, color: AppColors.neutral, size: 20),
              hintText: "Cari riwayat pemeriksaan...",
              hintStyle: TextStyle(color: AppColors.neutral, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip("Semua", "49", true, null),
              const SizedBox(width: 8),
              _buildFilterChip("Terindikasi Hoaks", "14", false, AppColors.danger),
              const SizedBox(width: 8),
              _buildFilterChip("Valid", "34", false, AppColors.primary),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFilterChip(String label, String count, bool isActive, Color? dotColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
            const SizedBox(width: 6),
          ],
          Text(label, style: TextStyle(color: isActive ? Colors.white : AppColors.inverted, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(width: 4),
          Text("($count)", style: TextStyle(color: isActive ? Colors.white70 : AppColors.neutral, fontSize: 12)),
        ],
      ),
    );
  }
}