
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';
import '../features/splash/pages/splash_page.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);


Future<void> loadThemePreference() async {
  final prefs = await SharedPreferences.getInstance();

  final isDarkMode = prefs.getBool('isDarkMode') ?? false;

  themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
}


Future<void> updateThemeMode(ThemeMode mode) async {
  themeNotifier.value = mode;

  final prefs = await SharedPreferences.getInstance();

  await prefs.setBool('isDarkMode', mode == ThemeMode.dark);
}

class HoaxCheckApp extends StatelessWidget {
  const HoaxCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HoaxCheck',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          home: const SplashPage(),
        );
      },
    );
  }
}
