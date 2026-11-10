import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../../../features/notification/presentation/pages/notification_page.dart'; // TAMBAHAN IMPORT

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppHeader({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.inverted,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // PERBAIKAN: Routing ke halaman Notifikasi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.notifications_outlined,
                  color: isDark ? Colors.white70 : AppColors.inverted,
                  size: 24,
                ),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  // Aksi ketika avatar profil diklik
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? Colors.white24 : Colors.grey.shade300,
                      width: 1.5,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/img_profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}