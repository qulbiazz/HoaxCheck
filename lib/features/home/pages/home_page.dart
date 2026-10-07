import 'package:flutter/material.dart';

import '../widgets/home_header.dart';
import '../widgets/greeting_section.dart';
import '../widgets/status_card.dart';
import '../widgets/literacy_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/detection_banner.dart';
import '../widgets/statistics_section.dart';
import '../widgets/recent_check_section.dart';
import '../widgets/news_section.dart';
import '../widgets/tips_section.dart';
import '../widgets/categories_section.dart';
import '../widgets/transparency_note.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cukup kembalikan Scaffold dengan SafeArea dan SingleChildScrollView
    // Tidak perlu lagi ada bottomNavigationBar di sini karena sudah diurus MainNavigation
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF), // Sesuaikan dengan warna background beranda Anda
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    GreetingSection(),
                    StatusCard(),
                    LiteracyCard(),
                    QuickActions(),
                    DetectionBanner(),
                    StatisticsSection(),
                    RecentCheckSection(),
                    NewsSection(),
                    TipsSection(),
                    CategoriesSection(),
                    TransparencyNote(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}