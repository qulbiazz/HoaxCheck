import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Halo, siap memeriksa informasi?",
                style: TextStyle(color: AppColors.inverted, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Kenali informasi yang meragukan dengan lebih mudah.",
                style: TextStyle(color: AppColors.neutral, fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
              child: const Icon(Icons.campaign_outlined, color: AppColors.inverted, size: 20),
            ),
            Positioned(
              right: 2, top: 2,
              child: Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: AppColors.danger, // <-- Titik merah menggunakan danger
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}