import 'package:flutter/material.dart';
import 'package:hoaxcheck_app/app/theme.dart'; 
import '../widgets/home_header.dart';
import '../widgets/greeting_section.dart';
import '../widgets/detection_banner.dart';
import '../widgets/quick_actions.dart';
import '../widgets/statistics_section.dart';
import '../widgets/recent_check_section.dart';
import '../widgets/tips_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // <-- Menggunakan Background Theme
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                HomeHeader(),
                SizedBox(height: 24),
                GreetingSection(),
                SizedBox(height: 20),
                DetectionBanner(),
                SizedBox(height: 24),
                QuickActions(),
                SizedBox(height: 28),
                StatisticsSection(),
                SizedBox(height: 28),
                RecentCheckSection(),
                SizedBox(height: 28),
                TipsSection(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}