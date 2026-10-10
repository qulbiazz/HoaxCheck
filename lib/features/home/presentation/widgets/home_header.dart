import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Beranda",
          style: TextStyle(
            color: AppColors.inverted, // <-- Judul
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: AppColors.neutral), // <-- Ikon
              onPressed: () {},
            ),
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surface, 
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ],
        )
      ],
    );
  }
}