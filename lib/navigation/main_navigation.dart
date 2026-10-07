import 'package:flutter/material.dart';
import '../features/home/pages/home_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan berdasarkan tab yang dipilih
  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text('Halaman Deteksi (Segera Hadir)')), // Placeholder
    const Center(child: Text('Halaman Riwayat (Segera Hadir)')), // Placeholder
    const Center(child: Text('Halaman Profil (Segera Hadir)')), // Placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: Color(0xFF00288E), fontSize: 12, fontWeight: FontWeight.bold);
            }
            return const TextStyle(color: Color(0xFF444653), fontSize: 12, fontWeight: FontWeight.normal);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: const Color(0xFFFFFFFF),
          indicatorColor: const Color(0xFFE5EEFF), // Warna latar biru muda untuk indikator pil
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Color(0xFF444653)),
              selectedIcon: Icon(Icons.home, color: Color(0xFF00288E)),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.verified_user_outlined, color: Color(0xFF444653)),
              selectedIcon: Icon(Icons.verified_user, color: Color(0xFF00288E)),
              label: 'Deteksi',
            ),
            NavigationDestination(
              icon: Icon(Icons.history, color: Color(0xFF444653)),
              selectedIcon: Icon(Icons.history, color: Color(0xFF00288E)),
              label: 'Riwayat',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined, color: Color(0xFF444653)),
              selectedIcon: Icon(Icons.account_circle, color: Color(0xFF00288E)),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}