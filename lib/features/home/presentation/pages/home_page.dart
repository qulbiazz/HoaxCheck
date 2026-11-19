import 'package:flutter/material.dart';
import '../../../../app/app_header.dart';
import '../../../../app/theme.dart';
import '../../../panduan/presentation/pages/guide_detail_page.dart';
import '../widgets/greeting_section.dart';
import '../widgets/detection_banner.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_check_section.dart';
import '../widgets/statistics_section.dart';
import '../widgets/tips_section.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onNavigateToDetection;
  final VoidCallback? onNavigateToHistory;

  const HomePage({
    super.key,
    this.onNavigateToDetection,
    this.onNavigateToHistory,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Key _refreshKey = UniqueKey();

  Future<void> _handleRefresh() async {
    setState(() {
      _refreshKey = UniqueKey();
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppColors.primary,
          child: SingleChildScrollView(
            key: _refreshKey,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppHeader(title: "Beranda"),
                  const SizedBox(height: 24),
                  const GreetingSection(),
                  const SizedBox(height: 20),
                  DetectionBanner(onNavigateToDetection: widget.onNavigateToDetection),
                  const SizedBox(height: 24),
                  QuickActions(
                    onTapDetection: widget.onNavigateToDetection,
                    onTapRiwayat: widget.onNavigateToHistory,
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
                  RecentCheckCard(onViewAllPressed: widget.onNavigateToHistory),
                  const SizedBox(height: 28),
                  const TipsSection(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
