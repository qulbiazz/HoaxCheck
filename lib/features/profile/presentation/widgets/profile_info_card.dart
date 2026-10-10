import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // PERBAIKAN: Warna kartu
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary.withOpacity(0.15), 
            child: const Icon(
              Icons.person,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Qulbi Khutsi Azzumi", 
            // PERBAIKAN: Warna nama dari tema
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "qulbi@hoaxcheck.id",
            style: TextStyle(color: isDark ? Colors.white54 : AppColors.neutral, fontSize: 12),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, size: 16),
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