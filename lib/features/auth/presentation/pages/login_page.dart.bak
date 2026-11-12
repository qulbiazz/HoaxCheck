import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;
import 'package:hoaxcheck_app/features/auth/presentation/pages/forgot_password_page.dart';
import '../../../../../app/theme.dart';
import '../../../../../core/widgets/hoaxcheck_logo.dart';
import '../../../../../navigation/main_navigation.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_with_email_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../widgets/auth_buttons.dart';
import '../widgets/custom_text_field.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isLoading = false;
  StreamSubscription? _authSubscription;

  // Clean Architecture: Injeksi UseCase & Repository
  late final AuthRepository _authRepository = AuthRepositoryImpl();
  late final LoginWithEmailUseCase _loginUseCase =
      LoginWithEmailUseCase(_authRepository);
  late final SignInWithGoogleUseCase _googleSignInUseCase =
      SignInWithGoogleUseCase(_authRepository);

  @override
  void initState() {
    super.initState();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    try {
      _authSubscription = _authRepository.authStateChanges.listen((user) {
        if (mounted && user != null) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MainNavigation(),
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        }
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await _googleSignInUseCase(
        kIsWeb ? null : 'io.supabase.hoaxcheck://login-callback',
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: AppColors.danger,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal masuk dengan Google: $e'),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      await _loginUseCase(LoginParams(email: email, password: password));

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainNavigation(),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.contains('Invalid login credentials')
                ? 'Email atau kata sandi salah.'
                : e.message,
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal masuk: $e'),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppDarkColors.primary : const Color(0xFF006B4D);
    final textColor =
        isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A);
    final textSecondary =
        isDark ? AppDarkColors.textSecondary : const Color(0xFF475569);

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            children: [
              HoaxCheckLogo(size: 76, backgroundColor: primaryColor),
              const SizedBox(height: 20),

              Text(
                'Selamat Datang di HoaxCheck',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Masuk untuk mulai memeriksa informasi yang\nkamu temukan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),

              // Form Container (Card)
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color:
                        isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Email',
                        hint: 'Masukkan email kamu',
                        prefixIcon: Icons.mail_outline_rounded,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator:
                            (v) =>
                                (v == null || v.isEmpty)
                                    ? 'Email tidak boleh kosong'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        hint: 'Masukkan kata sandi kamu',
                        prefixIcon: Icons.lock_outline_rounded,
                        controller: _passwordController,
                        isObscure: _isPasswordObscured,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF94A3B8),
                            size: 20,
                          ),
                          onPressed:
                              () => setState(
                                () =>
                                    _isPasswordObscured = !_isPasswordObscured,
                              ),
                        ),
                        validator:
                            (v) =>
                                (v == null || v.isEmpty)
                                    ? 'Password tidak boleh kosong'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Lupa password?',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      PrimaryAuthButton(
                        label: _isLoading ? 'Memeriksa...' : 'Masuk',
                        onPressed: _isLoading ? () {} : _onLogin,
                        hasShadow: true,
                      ),
                      const SizedBox(height: 16),
                      GoogleAuthButton(
                        label: 'Masuk dengan Google',
                        onPressed: _isLoading ? () {} : _onGoogleSignIn,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(fontSize: 14, color: textSecondary),
                  ),
                  GestureDetector(
                    onTap:
                        () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        ),
                    child: Text(
                      'Daftar sekarang',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 13,
                    color:
                        isDark
                            ? const Color(0xFF64748B)
                            : const Color(0xFF94A3B8),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Enkripsi 256-bit standar privasi data publik',
                    style: TextStyle(
                      fontSize: 11.5,
                      color:
                          isDark
                              ? const Color(0xFF64748B)
                              : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
