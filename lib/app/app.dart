import 'package:flutter/material.dart';
import '../navigation/main_navigation.dart';
import '../features/history/pages/history_detail_page.dart';
import '../features/detection/pages/analysis_detail_page.dart';
import 'theme.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class HoaxCheckApp extends StatelessWidget {
  final int initialIndex;
  final String? initialPage;
  const HoaxCheckApp({super.key, this.initialIndex = 0, this.initialPage});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        Widget homeWidget = MainNavigation(initialIndex: initialIndex);
        if (initialPage == 'history_detail') {
          homeWidget = const HistoryDetailPage();
        } else if (initialPage == 'analysis_detail') {
          homeWidget = const AnalysisDetailPage();
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HoaxCheck',
          theme: AppTheme.lightTheme, 
          darkTheme: AppTheme.darkTheme, 
          themeMode: currentMode, 
          home: homeWidget,
        );
      },
    );
  }
}