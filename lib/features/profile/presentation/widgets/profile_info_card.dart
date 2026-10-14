import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../app/theme.dart';
import '../pages/edit_profile_page.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Ambil data user dari sesi Supabase Auth (jika ada)
    User? currentUser;
    try {
      currentUser = Supabase.instance.client.auth.currentUser;
    } catch (_) {}

    final rawName = currentUser?.userMetadata?['full_name'] as String? ??
        currentUser?.userMetadata?['name'] as String?;
    final displayName = (rawName != null && rawName.trim().isNotEmpty)
        ? rawName.trim()
        : (currentUser?.email != null
            ? currentUser!.email!.split('@').first
            : "Qulbi Khutsi Azzumi");
    final displayEmail = currentUser?.email ?? "qulbi@hoaxcheck.id";
    final avatarUrl = currentUser?.userMetadata?['avatar_url'] as String?;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // PERBAIKAN: Warna kartu
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl) as ImageProvider
                : const AssetImage('assets/images/img_profile.png'),
          ),
          const SizedBox(height: 16),
          Text(
            displayName,
            // PERBAIKAN: Warna nama dari tema
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            displayEmail,
            style: TextStyle(
              color: isDark ? Colors.white54 : AppColors.neutral,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined, size: 16),
            label: const Text(
              "Edit Profil",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              foregroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
