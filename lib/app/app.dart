import 'package:flutter/material.dart';
import '../navigation/main_navigation.dart';
import 'theme.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

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
          home: const MainNavigation(),
        );
      },
    );
  }
}