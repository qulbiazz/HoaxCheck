import 'package:flutter/material.dart';
// import '../../../../../app/theme.dart';
import '../widgets/forgot_password_footer.dart';
import '../widgets/forgot_password_form_card.dart';
import '../widgets/forgot_password_header_nav.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // Logika pengiriman instruksi pemulihan password
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
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