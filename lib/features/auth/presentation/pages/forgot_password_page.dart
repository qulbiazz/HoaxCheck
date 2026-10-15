import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../widgets/forgot_password_footer.dart';
import '../widgets/forgot_password_form_card.dart';
import '../widgets/forgot_password_header_nav.dart';

class ForgotPasswordPage extends StatefulWidget {
  final AuthRepository? authRepository;

  const ForgotPasswordPage({super.key, this.authRepository});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final AuthRepository _authRepository;
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authRepository = widget.authRepository ?? AuthRepositoryImpl();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final email = _emailController.text.trim();
    if (email.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan alamat email yang valid'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authRepository.sendPasswordResetEmail(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tautan instruksi pemulihan kata sandi telah dikirim ke email Anda.',
            ),
            backgroundColor: AppColors.primary,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengirim tautan: $e'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              const ForgotPasswordHeaderNav(),
              const SizedBox(height: 20),
              ForgotPasswordFormCard(
                emailController: _emailController,
                onSubmit: _handleSubmit,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 24),
              const ForgotPasswordFooter(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}