import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            // Memberikan warna dasar hijau transparan dari primary
            backgroundColor: AppColors.primary.withOpacity(0.15), 
            backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(height: 16),
          const Text(
            "Qulbi Khutsi Azzumi", 
            style: TextStyle(color: AppColors.inverted, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "qulbi@hoaxcheck.id",
            style: TextStyle(color: AppColors.neutral, fontSize: 12),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, size: 16, color: AppColors.primary),
            label: const Text("Edit Profil", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withOpacity(0.1), 
              foregroundColor: AppColors.primary, 
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }
}