import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../pages/edit_profile_page.dart';

class ProfileInfoCard extends StatefulWidget {
  const ProfileInfoCard({super.key});

  @override
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  UserEntity? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    try {
      _currentUser = AuthRepositoryImpl().getCurrentUserSync();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final displayName = (_currentUser?.name != null && _currentUser!.name!.trim().isNotEmpty)
        ? _currentUser!.name!
        : "Qulbi Khutsi Azzumi";
    final displayEmail = (_currentUser?.email != null && _currentUser!.email.isNotEmpty)
        ? _currentUser!.email
        : "qulbi@hoaxcheck.id";
    final avatarUrl = _currentUser?.avatarUrl;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl) as ImageProvider
                : const AssetImage('assets/images/img_profile.png'),
          ),
          const SizedBox(height: 16),
          Text(
            displayName,
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
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
              if (result == true && mounted) {
                setState(() {
                  _loadUser();
                });
              }
            },
            icon: const Icon(Icons.edit_outlined, size: 16),
            label: const Text(
              "Edit Profil",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
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
