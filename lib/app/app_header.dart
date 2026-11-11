import 'dart:async';
import 'package:flutter/material.dart';
import 'theme.dart';
import '../core/widgets/user_avatar.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/entities/user_entity.dart';
import '../features/notification/presentation/pages/notification_page.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppHeader({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  UserEntity? _currentUser;
  StreamSubscription<UserEntity?>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _loadUser();
    try {
      _authSubscription = AuthRepositoryImpl().authStateChanges.listen((user) {
        if (mounted) {
          setState(() {
            _currentUser = user;
          });
        }
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  void _loadUser() {
    try {
      _currentUser = AuthRepositoryImpl().getCurrentUserSync();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
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
              UserAvatar(
                avatarUrl: _currentUser?.avatarUrl,
                size: 36,
                onTap: () {
                  // Aksi avatar jika diperlukan
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
