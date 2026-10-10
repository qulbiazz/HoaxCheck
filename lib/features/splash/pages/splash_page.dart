import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../core/widgets/hoaxcheck_logo.dart';
import '../../onboarding/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.9, curve: Curves.easeInOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToOnboarding();
      }
    });
  }

  void _navigateToOnboarding() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const OnboardingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppDarkColors.primary : const Color(0xFF006B4D);
    final backgroundColor = isDark ? AppDarkColors.neutral : const Color(0xFFFAFCFB);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background Gradient Glow at the Top
          Positioned(
            top: -80,
            left: 0,
            right: 0,
            height: 380,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: isDark
                      ? [
                          primaryColor.withValues(alpha: 0.25),
                          backgroundColor.withValues(alpha: 0.0),
                        ]
                      : [
                          const Color(0xFFD8F3EA),
                          const Color(0xFFEEF9F5),
                          backgroundColor.withValues(alpha: 0.0),
                        ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Main Content Centered
          SafeArea(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Spacer(flex: 4),

                    // App Logo Icon Card
                    HoaxCheckLogo(
                      size: 86,
                      backgroundColor: primaryColor,
                    ),

                    const SizedBox(height: 24),

                    // App Title
                    Text(
                      'HoaxCheck',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                        color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'Bantu Kenali Informasi yang\nMeragukan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Animated Linear Progress Bar
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, _) {
                        return Container(
                          width: 230,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2D3748)
                                : const Color(0xFFE2E8F0).withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: _progressAnimation.value.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // Progress Status Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sinkronisasi basis data fakta...',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppDarkColors.textSecondary : const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Pill Badge: Didukung NLP & Verifikasi Publik
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.psychology_alt_outlined,
                            size: 16,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Didukung NLP & Verifikasi Publik',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppDarkColors.textPrimary : const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Version Footer
                    Text(
                      'Versi 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                      ),
                    ),

                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
