import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../auth/pages/register_page.dart';

class OnboardingItem {
  final String stepText;
  final String categoryPill;
  final IconData categoryIcon;
  final String title;
  final String description;
  final String card1Title;
  final String card1Subtitle;
  final IconData card1Icon;
  final Color card1Bg;
  final Color card1IconColor;
  final String card2Title;
  final String card2Subtitle;
  final IconData card2Icon;
  final Color card2Bg;
  final Color card2IconColor;
  final Widget illustrationWidget;
  final BoxDecoration? illustrationDecoration;
  final Widget? customFeatureWidget;

  OnboardingItem({
    required this.stepText,
    required this.categoryPill,
    required this.categoryIcon,
    required this.title,
    required this.description,
    required this.card1Title,
    required this.card1Subtitle,
    required this.card1Icon,
    required this.card1Bg,
    required this.card1IconColor,
    required this.card2Title,
    required this.card2Subtitle,
    required this.card2Icon,
    required this.card2Bg,
    required this.card2IconColor,
    required this.illustrationWidget,
    this.illustrationDecoration,
    this.customFeatureWidget,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onFinishOnboarding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const RegisterPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppDarkColors.primary : const Color(0xFF006B4D);
    final backgroundColor = isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC);

    final List<OnboardingItem> items = [
      // STEP 1
      OnboardingItem(
        stepText: 'LANGKAH 1 DARI 3',
        categoryPill: 'Deteksi Dini Cerdas',
        categoryIcon: Icons.help_outline_rounded,
        title: 'Kenali Informasi yang\nMeragukan',
        description:
            'HoaxCheck membantu kamu mendapatkan indikasi awal terhadap informasi yang berpotensi hoaks melalui pemindaian pola linguistik dan data fakta terverifikasi.',
        card1Title: 'Pesan WhatsApp',
        card1Subtitle: 'Teks rantai & grup',
        card1Icon: Icons.chat_bubble_outline_rounded,
        card1Bg: const Color(0xFFD1FAE5),
        card1IconColor: const Color(0xFF047857),
        card2Title: 'Artikel Viral',
        card2Subtitle: 'Analisis tautan web',
        card2Icon: Icons.article_outlined,
        card2Bg: const Color(0xFFE0F2FE),
        card2IconColor: const Color(0xFF0284C7),
        illustrationDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
              isDark ? AppDarkColors.surface : const Color(0xFFD1FAE5).withValues(alpha: 0.8),
            ],
          ),
        ),
        illustrationWidget: _buildIllustrationStep1(isDark, primaryColor),
      ),
      // STEP 2
      OnboardingItem(
        stepText: 'LANGKAH 2 DARI 3',
        categoryPill: 'Alur Praktis 3 Detik',
        categoryIcon: Icons.timer_outlined,
        title: 'Periksa Teks dengan Mudah',
        description:
            'Masukkan atau tempel teks yang ingin kamu periksa, lalu biarkan HoaxCheck menganalisisnya secara objektif dengan kecerdasan buatan.',
        card1Title: '',
        card1Subtitle: '',
        card1Icon: Icons.abc,
        card1Bg: Colors.white,
        card1IconColor: Colors.white,
        card2Title: '',
        card2Subtitle: '',
        card2Icon: Icons.abc,
        card2Bg: Colors.white,
        card2IconColor: Colors.white,
        illustrationDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? const Color(0xFF1E293B) : const Color(0xFFD1FAE5).withValues(alpha: 0.7),
              isDark ? AppDarkColors.surface : const Color(0xFFEFF6FF),
            ],
          ),
        ),
        illustrationWidget: _buildIllustrationStep2(isDark, primaryColor),
        customFeatureWidget: _buildStep2Features(isDark),
      ),
      // STEP 3
      OnboardingItem(
        stepText: 'LANGKAH 3 DARI 3',
        categoryPill: 'Fondasi Literasi Digital',
        categoryIcon: Icons.timer_outlined,
        title: 'Periksa Teks dengan Mudah',
        description:
            'HoaxCheck adalah alat bantu deteksi awal, bukan pengganti verifikasi fakta.',
        card1Title: '', card1Subtitle: '', card1Icon: Icons.abc, card1Bg: Colors.white, card1IconColor: Colors.white,
        card2Title: '', card2Subtitle: '', card2Icon: Icons.abc, card2Bg: Colors.white, card2IconColor: Colors.white,
        illustrationDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
              isDark ? AppDarkColors.surface : const Color(0xFFEEF2FF),
            ],
          ),
        ),
        illustrationWidget: _buildIllustrationStep3(isDark, primaryColor),
        customFeatureWidget: _buildStep3Feature(isDark),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Header (Step badge + Skip Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF0F4F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      items[_currentIndex].stepText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _onFinishOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                    ),
                    child: const Text(
                      'Lewati',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView Content
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
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Illustration Box
                        Container(
                          width: double.infinity,
                          height: 280,
                          decoration: item.illustrationDecoration ?? BoxDecoration(
                            color: isDark ? AppDarkColors.surface : const Color(0xFFEEF7F6),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(child: item.illustrationWidget),
                        ),

                        const SizedBox(height: 20),

                        // Category Pill Tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? primaryColor.withValues(alpha: 0.2)
                                : const Color(0xFFD1FAE5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                item.categoryIcon,
                                size: 15,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.categoryPill,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Title
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                            color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Description
                        Text(
                          item.description,
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.45,
                            color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
                          ),
                        ),

                        const Spacer(),

                        // Feature Highlight Cards Row
                        if (item.customFeatureWidget != null)
                          item.customFeatureWidget!
                        else
                          Row(
                            children: [
                              Expanded(
                                child: _buildFeatureCard(
                                  title: item.card1Title,
                                  subtitle: item.card1Subtitle,
                                  icon: item.card1Icon,
                                  bg: item.card1Bg,
                                  iconColor: item.card1IconColor,
                                  isDark: isDark,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildFeatureCard(
                                  title: item.card2Title,
                                  subtitle: item.card2Subtitle,
                                  icon: item.card2Icon,
                                  bg: item.card2Bg,
                                  iconColor: item.card2IconColor,
                                  isDark: isDark,
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Indicators & Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Page Indicators (Dots) - Clickable
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(items.length, (index) {
                      final bool isActive = _currentIndex == index;
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 6,
                            width: isActive ? 24 : 6,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? primaryColor
                                  : (isDark ? Colors.white24 : const Color(0xFFCBD5E1)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentIndex == 2 ? 'Mulai Sekarang' : 'Berikutnya',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentIndex == 2 ? Icons.check_circle_outline : Icons.arrow_forward_rounded,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color bg,
    required Color iconColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : const Color(0xFFF1F5F9).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? iconColor.withValues(alpha: 0.2) : bg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildIllustrationStep1(bool isDark, Color primaryColor) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Background elements (dots)
        Positioned(left: 20, top: 40, child: _buildDot(const Color(0xFF94A3B8))),
        Positioned(right: 60, top: 20, child: _buildDot(const Color(0xFF64748B))),
        Positioned(left: 40, bottom: 40, child: _buildDot(const Color(0xFF10B981))),
        Positioned(right: 30, bottom: 60, child: _buildDot(const Color(0xFF34D399))),
        Positioned(right: 40, bottom: 20, child: _buildDot(const Color(0xFF94A3B8))),
        
        // The Phone Outline
        Container(
          width: 130,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF8FAFC), width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Speaker
              Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              
              // Top Notification Bubble
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 30, height: 6, decoration: BoxDecoration(color: const Color(0xFFFECACA), borderRadius: BorderRadius.circular(3))),
                        Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFFDC2626), shape: BoxShape.circle)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(width: double.infinity, height: 4, decoration: BoxDecoration(color: const Color(0xFF94A3B8), borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 6),
                    Container(width: 60, height: 4, decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2))),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Bottom Notification Bubble
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFDCFCE7)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 40, height: 6, decoration: BoxDecoration(color: const Color(0xFF6EE7B7), borderRadius: BorderRadius.circular(3))),
                    const SizedBox(height: 8),
                    Container(width: double.infinity, height: 4, decoration: BoxDecoration(color: const Color(0xFF94A3B8), borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 6),
                    Container(width: 50, height: 4, decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2))),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Scanning Dashed Line
        Positioned(
          top: 100, // roughly middle
          child: Container(
            width: 200, // wider than phone
            height: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(20, (index) => Container(width: 6, height: 2, color: const Color(0xFF047857))),
            ),
          ),
        ),

        // Floating Left Message Card
        Positioned(
          left: -10,
          top: 80,
          child: Container(
            width: 140,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 16, height: 16, decoration: const BoxDecoration(color: Color(0xFFDBEAFE), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Container(width: 60, height: 6, decoration: BoxDecoration(color: const Color(0xFF475569), borderRadius: BorderRadius.circular(3))),
                  ],
                ),
                const SizedBox(height: 10),
                Container(width: 80, height: 4, decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 6),
                Container(width: double.infinity, height: 4, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 6),
                Container(width: 50, height: 4, decoration: BoxDecoration(color: const Color(0xFFFECACA), borderRadius: BorderRadius.circular(2))),
              ],
            ),
          ),
        ),

        // Floating Right Shield
        Positioned(
          right: -5,
          bottom: 40,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF047857),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF047857).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 40,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Color(0xFF047857), size: 24),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildDot(Color color) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  static Widget _buildIllustrationStep2(bool isDark, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Teks Masuk
          _buildInfoCard(
            isDark: isDark,
            icon: Icons.content_paste_outlined,
            iconBg: const Color(0xFFE0F2FE),
            iconColor: const Color(0xFF047857),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Teks Masuk', style: TextStyle(fontSize: 11, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B), fontWeight: FontWeight.w600)),
                    const Text('142 Kata', style: TextStyle(fontSize: 11, color: Color(0xFF047857), fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 4),
                Text('"Beredar pesan rantai bahwa subsidi minyak goreng..."', style: TextStyle(fontSize: 11.5, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF334155), height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Mesin NLP
          _buildInfoCard(
            isDark: isDark,
            icon: Icons.psychology_outlined,
            iconBg: const Color(0xFFDBEAFE),
            iconColor: const Color(0xFF1E3A8A),
            content: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mesin NLP Klaritas', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A))),
                      const SizedBox(height: 2),
                      Text('Analisis semantik & fakta', style: TextStyle(fontSize: 11, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFA7F3D0), borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    children: [
                      Icon(Icons.auto_awesome, size: 12, color: Color(0xFF065F46)),
                      SizedBox(width: 4),
                      Text('98.4%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF065F46))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Terindikasi Hoaks
          _buildInfoCard(
            isDark: isDark,
            icon: Icons.gpp_bad_outlined,
            iconBg: const Color(0xFFFEE2E2),
            iconColor: const Color(0xFFB91C1C),
            content: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Klasifikasi Otomatis', style: TextStyle(fontSize: 11, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text('Terindikasi Hoaks', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFFECACA), borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    children: [
                      Icon(Icons.cancel_outlined, size: 12, color: Color(0xFF991B1B)),
                      SizedBox(width: 4),
                      Text('Palsu', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF991B1B))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildInfoCard({required bool isDark, required IconData icon, required Color iconBg, required Color iconColor, required Widget content}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? iconColor.withValues(alpha: 0.2) : iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(child: content),
        ],
      ),
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

  Widget _buildVerticalFeatureCard(String stepNum, String title, String subtitle, IconData icon, Color iconBg, Color iconColor, bool isDark, {Color? iconContainerBg, Color? subtitleColor}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
          width: 1,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stepNum,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF047857),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDark ? iconColor.withValues(alpha: 0.2) : (iconContainerBg ?? iconBg),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconContainerBg != null ? Colors.white : iconColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: subtitleColor ?? (isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B)),
              fontWeight: subtitleColor != null ? FontWeight.w600 : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  static Widget _buildIllustrationStep3(bool isDark, Color primaryColor) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Background large light green circle on top right
        Positioned(
          right: -10,
          top: -10,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5).withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Document Card
        Container(
          width: 140,
          height: 190,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top header line
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF047857),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF047857),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(width: double.infinity, height: 6, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 10),
              Container(width: 90, height: 6, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 10),
              Container(width: 100, height: 6, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 10),
              Container(width: 70, height: 6, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 16),
              // Bottom part inside document
              Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFA7F3D0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, size: 12, color: Color(0xFF047857)),
                  ),
                  const SizedBox(width: 8),
                  Container(width: 50, height: 6, decoration: BoxDecoration(color: const Color(0xFFA7F3D0), borderRadius: BorderRadius.circular(3))),
                ],
              ),
            ],
          ),
        ),
        // Shield Icon (Right)
        Positioned(
          right: -10,
          bottom: 30,
          child: Container(
            width: 36,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF047857),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.check, color: Colors.white, size: 20),
            ),
          ),
        ),
        // Anchor/Balance scale decorative lines (Left)
        Positioned(
          left: -10,
          top: 60,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(width: 2, height: 30, color: const Color(0xFF64748B)),
                Container(width: 24, height: 2, color: const Color(0xFF64748B)),
                Positioned(top: 0, child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF64748B), shape: BoxShape.circle))),
                Positioned(
                  bottom: 0,
                  left: 4,
                  child: Container(
                    width: 12,
                    height: 8,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF64748B), width: 2),
                        left: BorderSide(color: Color(0xFF64748B), width: 2),
                      ),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Container(
                    width: 12,
                    height: 8,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF64748B), width: 2),
                        right: BorderSide(color: Color(0xFF64748B), width: 2),
                      ),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Green Sparkle (Top Left)
        const Positioned(
          left: 10,
          top: 0,
          child: Icon(Icons.auto_awesome, color: Color(0xFF047857), size: 24),
        ),
        // Blue Sparkle (Top Right)
        const Positioned(
          right: 10,
          top: 15,
          child: Icon(Icons.auto_awesome, color: Color(0xFF1E3A8A), size: 16),
        ),
        // Magnifying Glass
        Positioned(
          bottom: 15,
          right: 5,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Handle
              Positioned(
                bottom: -22,
                right: -12,
                child: Transform.rotate(
                  angle: -0.785, // -45 degrees
                  child: Container(
                    width: 14,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Container(
                        width: 4,
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xFF047857),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Lens
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1E293B), width: 6),
                  color: const Color(0xFFD1FAE5).withValues(alpha: 0.6),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(4, 4)),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(color: Color(0xFF047857), shape: BoxShape.circle),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep3Feature(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E3A8A).withValues(alpha: 0.3) : const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.verified_user_outlined, color: Color(0xFF1E40AF), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Selalu periksa informasi melalui sumber terpercaya\nsebelum mempercayai atau membagikannya.',
              style: TextStyle(
                fontSize: 12.5,
                color: isDark ? AppDarkColors.textPrimary : const Color(0xFF1E3A8A),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
