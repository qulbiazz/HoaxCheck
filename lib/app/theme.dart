import 'package:flutter/material.dart';

class AppTheme {
  // Tema Terang (Light Theme)
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF8F9FF),
      primaryColor: const Color(0xFF00288E),
      
      // Konfigurasi ColorScheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00288E),
        primary: const Color(0xFF00288E),
        secondary: const Color(0xFF86F2E4), // Warna toska dari badge UI
        surface: const Color(0xFFFFFFFF),
        error: const Color(0xFFBA1A1A), // Warna merah error/hoaks
      ),
      
      // Konfigurasi AppBar Default
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF0B1C30)),
        titleTextStyle: TextStyle(
          color: Color(0xFF0B1C30),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // Konfigurasi Text Default
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF0B1C30)), // Warna teks utama
        bodyMedium: TextStyle(color: Color(0xFF444653)), // Warna teks sekunder
      ),
    );
  }

  // Jika nanti Anda butuh Dark Mode, Anda bisa menambahkannya di sini
  /*
  static ThemeData get dark {
    return ThemeData(
      // ... konfigurasi dark theme
    );
  }
  */
}