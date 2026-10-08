import 'package:flutter/material.dart';

class AppColors {
  // Palet Utama dari Guideline
  static const Color primary = Color(0xFF1CA379);
  static const Color secondary = Color(0xFF5AC596);
  static const Color tertiary = Color(0xFF7BB3E6);
  static const Color neutral = Color(0xFF6B7280);

  // Warna pendukung untuk komponen (berdasarkan visual gambar)
  static const Color inverted = Color(0xFF1F2937); // Gelap kebiruan untuk tombol Inverted
  static const Color background = Color(0xFFF0F4F8); // Latar belakang abu-abu terang
  static const Color surface = Colors.white;
  static const Color danger = Color(0xFFD32F2F); // Untuk ikon/tombol hapus
}

class AppTheme {
  static var light;

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
      
      // Tipografi (Headline, Body, Label)
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.inverted), // Headline
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.inverted), // Body
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.neutral), // Label
      ),

      // Gaya Komponen: Input Field (Search)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.neutral, fontSize: 14),
      ),

      // Gaya Komponen: ElevatedButton (Primary & Inverted)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Inter'),
        ),
      ),

      // Gaya Komponen: OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.inverted,
          side: const BorderSide(color: AppColors.neutral),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Inter'),
        ),
      ),
    );
  }
}