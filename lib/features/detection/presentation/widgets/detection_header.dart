import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class DetectionHeader extends StatelessWidget {
  const DetectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Deteksi",
              style: TextStyle(
                color: AppColors.inverted,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: AppColors.neutral),
                  onPressed: () {},
                ),
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
        
        // Title & Subtitle Section
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.security, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              "Deteksi Hoaks",
              style: TextStyle(color: AppColors.inverted, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Masukkan teks yang ingin kamu periksa dengan model AI & NLP terverifikasi.",
          style: TextStyle(color: AppColors.neutral, fontSize: 13, height: 1.4),
        ),
      ],
    );
  }
}