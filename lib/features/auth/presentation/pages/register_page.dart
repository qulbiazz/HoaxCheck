import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../../../core/widgets/hoaxcheck_logo.dart';
import '../../../../../navigation/main_navigation.dart';
import '../../../privacy_policy/presentation/pages/privacy_policy_page.dart';
import '../widgets/auth_buttons.dart';
import '../widgets/custom_text_field.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmObscured = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap menyetujui Kebijakan Privasi.'),
            backgroundColor: AppColors.danger,
          ),
        );
        return;
      }
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, __, ___) => const MainNavigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppDarkColors.primary : const Color(0xFF006B4D);
    final textSecondary =
        isDark ? AppDarkColors.textSecondary : const Color(0xFF475569);

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              HoaxCheckLogo(size: 76, backgroundColor: primaryColor),
              const SizedBox(height: 20),

              Text(
                'Buat Akun HoaxCheck',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:
                      isDark
                          ? AppDarkColors.textPrimary
                          : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Daftar untuk mulai menggunakan HoaxCheck.',
                style: TextStyle(fontSize: 14, color: textSecondary),
              ),
              const SizedBox(height: 24),

              // Form Container
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
                        label: 'Nama Lengkap',
                        hint: 'Masukkan nama kamu',
                        prefixIcon: Icons.person_outline_rounded,
                        controller: _nameController,
                        validator:
                            (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'Tidak boleh kosong'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Email',
                        hint: 'nama@email.com',
                        prefixIcon: Icons.mail_outline_rounded,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator:
                            (v) =>
                                (v != null && v.contains('@'))
                                    ? null
                                    : 'Email tidak valid',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        hint: 'Minimal 8 karakter',
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
                                (v == null || v.length < 8)
                                    ? 'Minimal 8 karakter'
                                    : null,
                        bottomNote: Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 13,
                              color: textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Minimal 8 karakter',
                              style: TextStyle(
                                fontSize: 12,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Konfirmasi Password',
                        hint: 'Masukkan kembali password',
                        prefixIcon: Icons.refresh_rounded,
                        controller: _confirmController,
                        isObscure: _isConfirmObscured,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmObscured
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF94A3B8),
                            size: 20,
                          ),
                          onPressed:
                              () => setState(
                                () => _isConfirmObscured = !_isConfirmObscured,
                              ),
                        ),
                        validator:
                            (v) =>
                                (v != _passwordController.text)
                                    ? 'Password tidak cocok'
                                    : null,
                      ),
                      const SizedBox(height: 16),

                      // Checkbox
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _agreeTerms,
                              activeColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged:
                                  (val) => setState(
                                    () => _agreeTerms = val ?? false,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap:
                                  () => setState(
                                    () => _agreeTerms = !_agreeTerms,
                                  ),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color:
                                        isDark
                                            ? AppDarkColors.textPrimary
                                            : const Color(0xFF334155),
                                  ),
                                  children: [
                                    const TextSpan(text: 'Saya menyetujui '),
                                    TextSpan(
                                      text: 'Kebijakan Privasi',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      // Tambahkan recognizer di sini
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          const PrivacyPolicyPage(),
                                                ),
                                              );
                                            },
                                    ),
                                    const TextSpan(text: ' HoaxCheck.'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      PrimaryAuthButton(
                        label: 'Daftar Akun',
                        onPressed: _onRegister,
                      ),
                      const SizedBox(height: 12),
                      GoogleAuthButton(
                        label: 'Register dengan Google',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun? ',
                    style: TextStyle(fontSize: 14, color: textSecondary),
                  ),
                  GestureDetector(
                    onTap:
                        () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        ),
                    child: Text(
                      'Masuk',
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
