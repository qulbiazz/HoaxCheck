import 'package:flutter/material.dart';
import 'package:hoaxcheck_app/app/app.dart';
import '../../../../../app/theme.dart';
// import '../../../../main.dart';

import '../widgets/profile_info_card.dart';
import '../widgets/profile_stats_card.dart';
import '../widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile", 
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20)
                    ),
                    Row(
                      children: [
                        IconButton(icon: const Icon(Icons.notifications_outlined, color: AppColors.neutral), onPressed: () {}),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primary.withOpacity(0.2),
                          backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                
                const ProfileInfoCard(),
                const SizedBox(height: 24),
                
                const ProfileStatsCard(),
                const SizedBox(height: 28),
                
                const Text("PREFERENSI", style: TextStyle(color: AppColors.neutral, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface, 
                    borderRadius: BorderRadius.circular(16), 
                    boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))]
                  ),
                  child: ValueListenableBuilder<ThemeMode>(
                    valueListenable: themeNotifier,
                    builder: (context, currentMode, child) {
                      final isDarkMode = currentMode == ThemeMode.dark;
                      
                      return ProfileMenuItem(
                        icon: Icons.dark_mode_outlined,
                        title: "Mode Gelap",
                        subtitle: "Tampilan redup untuk mata",
                        trailing: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                          },
                          activeColor: AppColors.primary,
                        ),
                        onTap: () {
                          themeNotifier.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                const Text("TENTANG APLIKASI", style: TextStyle(color: AppColors.neutral, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface, 
                    borderRadius: BorderRadius.circular(16), 
                    boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))]
                  ),
                  child: Column(
                    children: [
                      ProfileMenuItem(icon: Icons.info_outline, title: "Tentang HoaxCheck", onTap: () {}),
                      const Divider(height: 1, color: Color(0xFFF3F4F6), indent: 64),
                      ProfileMenuItem(icon: Icons.lock_outline, title: "Kebijakan Privasi", onTap: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Text("BANTUAN", style: TextStyle(color: AppColors.neutral, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface, 
                    borderRadius: BorderRadius.circular(16), 
                    boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))]
                  ),
                  child: ProfileMenuItem(icon: Icons.flag_outlined, title: "Laporkan Masalah", onTap: () {}),
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout, size: 18, color: AppColors.danger),
                    label: const Text("Keluar Akun", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.danger.withOpacity(0.08),
                      foregroundColor: AppColors.danger,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                const Center(child: Text("HoaxCheck v1.0.0", style: TextStyle(color: AppColors.neutral, fontSize: 10, fontWeight: FontWeight.bold))),
                const SizedBox(height: 100), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}