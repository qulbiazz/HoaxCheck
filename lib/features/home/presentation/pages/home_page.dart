import 'package:flutter/material.dart';
import 'package:hoaxcheck_app/app/theme.dart';
import '../../../panduan/presentation/pages/guide_detail_page.dart';
import '../../widgets/recent_check_section.dart';
import '../widgets/home_header.dart';
import '../widgets/greeting_section.dart';
import '../widgets/detection_banner.dart';
import '../widgets/quick_actions.dart';
import '../widgets/statistics_section.dart';
import '../widgets/recent_check_section.dart';
import '../widgets/tips_section.dart';
// Import halaman panduanmu di sini (sesuaikan path foldernya)
// import '../../panduan/presentation/pages/panduan_page.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onNavigateToDetection;
  final VoidCallback? onNavigateToHistory;

  const HomePage({
    super.key,
    this.onNavigateToDetection,
    this.onNavigateToHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(),
                const SizedBox(height: 24),
                const GreetingSection(),
                const SizedBox(height: 20),

                DetectionBanner(onNavigateToDetection: onNavigateToDetection),

                const SizedBox(height: 24),

                QuickActions(
                  onTapDetection: onNavigateToDetection,
                  onTapRiwayat: onNavigateToHistory,
                  onTapPanduan: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GuideDetailPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 28),
                const StatisticsSection(),
                const SizedBox(height: 28),
                RecentCheckSection(onViewAllPressed: onNavigateToHistory),
                const SizedBox(height: 28),
                const TipsSection(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
