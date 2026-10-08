import 'package:flutter/material.dart';
import '../features/history/pages/history_page.dart';
import '../features/home/pages/home_page.dart';
import '../features/detection/pages/detection_page.dart';
import '../app/theme.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DetectionPage(),
    const HistoryPage(),
    const Center(child: Text('Halaman Profil (Segera Hadir)')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Memastikan konten bisa discroll hingga ke balik navbar
      body: Stack(
        children: [
          _pages[_selectedIndex], // Halaman utama
          
          Align(
            alignment: Alignment.bottomCenter, // Selalu mengunci navbar di bawah
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                padding: const EdgeInsets.symmetric(vertical: 10), 
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _buildNavItem(index: 0, icon: Icons.home_outlined, label: 'Beranda'),
                    _buildNavItem(index: 1, icon: Icons.document_scanner_outlined, label: 'Deteksi'),
                    _buildNavItem(index: 2, icon: Icons.history, label: 'Riwayat'),
                    _buildNavItem(index: 3, icon: Icons.person_outline, label: 'Profile'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required int index, required IconData icon, required String label}) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque, // Memastikan seluruh area bisa diklik
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Diperlebar agar seimbang
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(100), // Diubah menjadi 100 agar membulat sempurna
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: isSelected ? AppColors.primary : AppColors.inverted,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.inverted,
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