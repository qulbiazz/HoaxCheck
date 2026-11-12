import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../app/theme.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../navigation/main_navigation.dart';
import '../../auth/presentation/pages/login_page.dart';
import '../../onboarding/presentation/pages/onboarding_page.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_loading.dart';
import '../widgets/splash_footer.dart';

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
        _navigateToNextScreen();
      }
    });
  }

  Future<void> _navigateToNextScreen() async {
    if (!mounted) return;

    try {
      final currentSession = Supabase.instance.client.auth.currentSession;
      final hasEverLoggedIn = await StorageService.hasLoggedIn();
      final hasSeenOnboarding = await StorageService.hasSeenOnboarding();

      if (!mounted) return;

      // 1. Jika masih memiliki sesi login aktif -> langsung ke halaman utama
      if (currentSession != null) {
        await StorageService.setHasLoggedIn(true);
        if (!mounted) return;
        _navigateWithFade(const MainNavigation());
        return;
      }

      // 2. Jika user sudah pernah login sebelumnya (atau menyelesaikan onboarding) -> langsung ke Login Page
      if (hasEverLoggedIn || hasSeenOnboarding) {
        if (!mounted) return;
        _navigateWithFade(const LoginPage());
        return;
      }
    } catch (e) {
      debugPrint('Routing error pada SplashPage: $e');
    }

    // 3. Pengguna baru (belum pernah login/onboarding) -> tampilkan Onboarding
    if (!mounted) return;
    _navigateWithFade(const OnboardingPage());
  }

  void _navigateWithFade(Widget destination) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
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
                    SplashLogo(
                      isDark: isDark,
                      primaryColor: primaryColor,
                    ),
                    const SizedBox(height: 48),
                    SplashLoading(
                      progressAnimation: _progressAnimation,
                      isDark: isDark,
                      primaryColor: primaryColor,
                    ),
                    const SizedBox(height: 28),
                    SplashFooter(
                      isDark: isDark,
                      primaryColor: primaryColor,
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