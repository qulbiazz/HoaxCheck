import 'package:flutter/material.dart';

import '../navigation/main_navigation.dart'; // Import navigation yang baru
import 'theme.dart';

class HoaxCheckApp extends StatelessWidget {
  const HoaxCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HoaxCheck',
      theme: AppTheme.light,
      home: const MainNavigation(), // Gunakan MainNavigation sebagai entry point
    );
  }
}