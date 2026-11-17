import 'package:flutter/material.dart';
import '../../auth/pages/register_page.dart';
import 'onboarding_step1_page.dart';
import 'onboarding_step2_page.dart';
import 'onboarding_step3_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = const [
    OnboardingStep1Page(),
    OnboardingStep2Page(),
    OnboardingStep3Page(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _onSkip() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Step Count & Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      color: const Color(0xFFF0F3FF),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(
                      "LANGKAH ${_currentPage + 1} DARI ${_pages.length}",
                      style: const TextStyle(
                        color: Color(0xFF00694C),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _onSkip,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF6D7A73),
                    ),
                    child: const Text(
                      "Lewati",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page View content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _pages,
              ),
            ),

            // Bottom controls with indicators and next button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          color: _currentPage == index
                              ? const Color(0xFF00694C)
                              : const Color(0xFFBCCAC1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Button (Next / Get Started)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00694C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == _pages.length - 1
                                ? "Mulai Sekarang"
                                : "Berikutnya",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == _pages.length - 1
                                ? Icons.check_circle_outline_rounded
                                : Icons.arrow_forward_rounded,
                            size: 18,
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
}

// Backward compatibility alias
typedef OnBoarding = OnboardingPage;
