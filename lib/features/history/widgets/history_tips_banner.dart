import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class HistoryTipsBanner extends StatelessWidget {
  const HistoryTipsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE), // Biru pucat
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.3), shape: BoxShape.circle),
            child: const Icon(Icons.lightbulb, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tips Literasi Digital", style: TextStyle(color: AppColors.inverted, fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Periksa domain web resmi sebelum menyebarkan tautan pembagian bantuan atau subsidi.", style: TextStyle(color: AppColors.neutral, fontSize: 11, height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }
}