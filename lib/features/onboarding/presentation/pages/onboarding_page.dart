import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_navigation.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onFinishOnboarding() {
    debugPrint("Onboarding Selesai!");
  }

  void _nextPage() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _onFinishOnboarding();
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppDarkColors.primary : const Color(0xFF006B4D); 
    final backgroundColor = isDark ? AppDarkColors.surface : Colors.white;

    final List<OnboardingItem> items = [
      OnboardingItem(
        stepText: 'LANGKAH 1 DARI 3',
        categoryPill: 'Deteksi Dini Cerdas',
        categoryIcon: Icons.shield_outlined,
        title: 'Kenali Informasi yang\nMeragukan',
        description: 'HoaxCheck membantu kamu mendapatkan indikasi awal terhadap informasi yang berpotensi hoaks melalui pemindaian pola linguistik dan data fakta terverifikasi.',
        imagePath: 'assets/images/onboarding_1.png',
        customFeatureWidget: _buildStep1Features(isDark),
      ),
      OnboardingItem(
        stepText: 'LANGKAH 2 DARI 3',
        categoryPill: 'Alur Praktis 3 Detik',
        categoryIcon: Icons.timer_outlined,
        title: 'Periksa Teks dengan Mudah',
        description: 'Masukkan atau tempel teks yang ingin kamu periksa, lalu biarkan HoaxCheck menganalisisnya secara objektif dengan kecerdasan buatan.',
        imagePath: 'assets/images/onboarding_2.png',
        customFeatureWidget: _buildStep2Features(isDark),
      ),
      OnboardingItem(
        stepText: 'LANGKAH 3 DARI 3',
        categoryPill: 'Fondasi Literasi Digital',
        categoryIcon: Icons.menu_book_outlined,
        title: 'Periksa Teks dengan Mudah',
        description: 'HoaxCheck adalah alat bantu deteksi awal, bukan pengganti verifikasi fakta.',
        imagePath: 'assets/images/onboarding_3.png',
        customFeatureWidget: _buildStep3Feature(isDark),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentIndex > 0)
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: isDark ? Colors.white : Colors.black,
                      onPressed: _previousPage,
                    )
                  else
                    const SizedBox(width: 48),
                  if (_currentIndex < 2)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF0F4F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        items[_currentIndex].stepText,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.4, color: primaryColor),
                      ),
                    )
                  else
                    const Spacer(),
                  TextButton(
                    onPressed: _onFinishOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: _currentIndex == 2 ? primaryColor : (isDark ? Colors.white70 : const Color(0xFF64748B)),
                    ),
                    child: Text(
                      _currentIndex == 2 ? 'Mulai' : 'Lewati', 
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingContent(
                    item: items[index],
                    isDark: isDark,
                    primaryColor: primaryColor,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  OnboardingIndicator(
                    itemCount: items.length,
                    currentIndex: _currentIndex,
                    primaryColor: primaryColor,
                    isDark: isDark,
                    onPageSelected: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  OnboardingNavigation(
                    currentIndex: _currentIndex,
                    totalPages: items.length,
                    primaryColor: primaryColor,
                    onNext: _nextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1Features(bool isDark) {
    return Row(
      children: [
        Expanded(child: _buildHorizontalFeatureCard('Pesan WhatsApp', 'Teks rantai & grup', Icons.chat_bubble_outline_rounded, const Color(0xFFD1FAE5), const Color(0xFF047857), isDark)),
        const SizedBox(width: 12),
        Expanded(child: _buildHorizontalFeatureCard('Artikel Viral', 'Analisis tautan web', Icons.article_outlined, const Color(0xFFE0F2FE), const Color(0xFF0284C7), isDark)),
      ],
    );
  }

  Widget _buildStep2Features(bool isDark) {
    return Row(
      children: [
        Expanded(child: _buildVerticalFeatureCard('01', 'Tempel', 'Input teks', Icons.content_paste_outlined, const Color(0xFFD1FAE5), const Color(0xFF047857), isDark)),
        const SizedBox(width: 8),
        Expanded(child: _buildVerticalFeatureCard('02', 'Analisis', 'Model NLP', Icons.psychology_outlined, const Color(0xFF047857), Colors.white, isDark, iconContainerBg: const Color(0xFF047857), subtitleColor: const Color(0xFF047857))),
        const SizedBox(width: 8),
        Expanded(child: _buildVerticalFeatureCard('03', 'Hasil', 'Skor akurasi', Icons.speed_outlined, const Color(0xFFE0F2FE), const Color(0xFF0284C7), isDark)),
      ],
    );
  }

  Widget _buildStep3Feature(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: isDark ? const Color(0xFF1E3A8A).withOpacity(0.3) : const Color(0xFFDBEAFE), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.verified_user_outlined, color: Color(0xFF1E40AF), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Selalu periksa informasi melalui sumber terpercaya\nsebelum mempercayai atau membagikannya.',
              style: TextStyle(fontSize: 12.5, color: isDark ? Colors.white : const Color(0xFF1E3A8A), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalFeatureCard(String title, String subtitle, IconData icon, Color bg, Color iconColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9).withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: isDark ? iconColor.withOpacity(0.2) : bg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A)), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 10, color: isDark ? Colors.white70 : const Color(0xFF64748B)), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalFeatureCard(String stepNum, String title, String subtitle, IconData icon, Color iconBg, Color iconColor, bool isDark, {Color? iconContainerBg, Color? subtitleColor}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9), width: 1),
        boxShadow: [if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(stepNum, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF047857))),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: isDark ? iconColor.withOpacity(0.2) : (iconContainerBg ?? iconBg), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, size: 16, color: iconContainerBg != null ? Colors.white : iconColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A))),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: subtitleColor ?? (isDark ? Colors.white70 : const Color(0xFF64748B)), fontWeight: subtitleColor != null ? FontWeight.w600 : FontWeight.normal),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}