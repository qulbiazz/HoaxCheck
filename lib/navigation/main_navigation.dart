import 'package:flutter/material.dart';
import '../features/home/pages/home_page.dart';
import '../features/detection/pages/detection_page.dart';
import '../features/history/pages/history_page.dart'; // Sesuaikan import jika perlu
import '../features/profile/pages/profile_page.dart'; // Sesuaikan import jika perlu
import '../app/theme.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const HomePage(),
    const DetectionPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _pages[_selectedIndex],
          
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                padding: const EdgeInsets.symmetric(vertical: 10), 
                decoration: BoxDecoration(
                  // PERBAIKAN: Gunakan warna surface dari Theme agar bisa berubah gelap/terang
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _buildNavItem(index: 0, icon: Icons.home_outlined, label: 'Beranda', context: context),
                    _buildNavItem(index: 1, icon: Icons.document_scanner_outlined, label: 'Deteksi', context: context),
                    _buildNavItem(index: 2, icon: Icons.history, label: 'Riwayat', context: context),
                    _buildNavItem(index: 3, icon: Icons.person_outline, label: 'Profile', context: context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required int index, required IconData icon, required String label, required BuildContext context}) {
    final bool isSelected = _selectedIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(100), 
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 24,
                    // PERBAIKAN: Warna ikon menyesuaikan tema
                    color: isSelected ? AppColors.primary : (isDark ? Colors.white54 : AppColors.inverted),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      // PERBAIKAN: Warna teks menyesuaikan tema
                      color: isSelected ? AppColors.primary : (isDark ? Colors.white54 : AppColors.inverted),
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}