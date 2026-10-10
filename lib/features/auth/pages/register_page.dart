import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../core/widgets/hoaxcheck_logo.dart';
import '../../../navigation/main_navigation.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _agreeTerms = false;

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap menyetujui Kebijakan Privasi terlebih dahulu.'),
            backgroundColor: AppColors.danger,
          ),
        );
        return;
      }
      // Navigasi ke Halaman Utama setelah pendaftaran sukses
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainNavigation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppDarkColors.primary : const Color(0xFF006B4D);
    final backgroundColor = isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC);
    final fieldFillColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // App Logo Card
              HoaxCheckLogo(
                size: 76,
                backgroundColor: primaryColor,
              ),

              const SizedBox(height: 20),

              // Header Title
              Text(
                'Buat Akun HoaxCheck',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.4,
                  color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 6),

              // Header Subtitle
              Text(
                'Daftar untuk mulai menggunakan HoaxCheck.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 24),

              // Form Card Container
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Field 1: Nama Lengkap
                      _buildFieldLabel('Nama Lengkap', isDark),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(fontSize: 14, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A)),
                        decoration: _buildInputDecoration(
                          hint: 'Masukkan nama kamu',
                          prefixIcon: Icons.person_outline_rounded,
                          fillColor: fieldFillColor,
                          isDark: isDark,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama lengkap tidak boleh kosong';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Field 2: Email
                      _buildFieldLabel('Email', isDark),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 14, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A)),
                        decoration: _buildInputDecoration(
                          hint: 'nama@email.com',
                          prefixIcon: Icons.mail_outline_rounded,
                          fillColor: fieldFillColor,
                          isDark: isDark,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Field 3: Password
                      _buildFieldLabel('Password', isDark),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordObscured,
                        style: TextStyle(fontSize: 14, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A)),
                        decoration: _buildInputDecoration(
                          hint: 'Minimal 8 karakter',
                          prefixIcon: Icons.lock_outline_rounded,
                          fillColor: fieldFillColor,
                          isDark: isDark,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: const Color(0xFF94A3B8),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.info_outline_rounded, size: 13, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B)),
                          const SizedBox(width: 4),
                          Text(
                            'Minimal 8 karakter',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Field 4: Konfirmasi Password
                      _buildFieldLabel('Konfirmasi Password', isDark),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _isConfirmPasswordObscured,
                        style: TextStyle(fontSize: 14, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A)),
                        decoration: _buildInputDecoration(
                          hint: 'Masukkan kembali password',
                          prefixIcon: Icons.refresh_rounded,
                          fillColor: fieldFillColor,
                          isDark: isDark,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: const Color(0xFF94A3B8),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Konfirmasi password tidak cocok';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Checkbox Kebijakan Privasi
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              onChanged: (val) {
                                setState(() {
                                  _agreeTerms = val ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _agreeTerms = !_agreeTerms;
                                });
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontFamily: 'Inter',
                                    color: isDark ? AppDarkColors.textPrimary : const Color(0xFF334155),
                                  ),
                                  children: [
                                    const TextSpan(text: 'Saya menyetujui '),
                                    TextSpan(
                                      text: 'Kebijakan Privasi',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
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

                      // Button: Daftar Akun ->
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _onRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Daftar Akun',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Button: Register dengan Google
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            _onRegister();
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
                            foregroundColor: primaryColor,
                            side: BorderSide(
                              color: isDark ? primaryColor : primaryColor,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildGoogleIcon(),
                              const SizedBox(width: 10),
                              Text(
                                'Register dengan Google',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Footer: Sudah punya akun? Masuk
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun? ',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToLogin,
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

              // Footer info 256-bit encryption
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 13,
                    color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Enkripsi 256-bit standar privasi data publik',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, bool isDark) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData prefixIcon,
    required Color fillColor,
    required bool isDark,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 13.5,
        color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
        size: 20,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: isDark ? AppDarkColors.primary : const Color(0xFF006B4D),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.danger, width: 1),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

// Custom Painter to render Google's iconic G logo cleanly
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint redPaint = Paint()..color = const Color(0xFFEA4335);
    final Paint bluePaint = Paint()..color = const Color(0xFF4285F4);
    final Paint greenPaint = Paint()..color = const Color(0xFF34A853);
    final Paint yellowPaint = Paint()..color = const Color(0xFFFBBC05);

    final Path bluePath = Path()
      ..moveTo(w * 0.95, h * 0.5)
      ..cubicTo(w * 0.95, h * 0.44, w * 0.94, h * 0.38, w * 0.92, h * 0.33)
      ..lineTo(w * 0.5, h * 0.33)
      ..lineTo(w * 0.5, h * 0.54)
      ..lineTo(w * 0.76, h * 0.54)
      ..cubicTo(w * 0.75, h * 0.62, w * 0.7, h * 0.69, w * 0.62, h * 0.74)
      ..lineTo(w * 0.62, h * 0.9)
      ..lineTo(w * 0.78, h * 0.9)
      ..cubicTo(w * 0.88, h * 0.81, w * 0.95, h * 0.67, w * 0.95, h * 0.5);

    final Path greenPath = Path()
      ..moveTo(w * 0.5, h * 0.95)
      ..cubicTo(w * 0.67, h * 0.95, w * 0.81, h * 0.89, w * 0.9, h * 0.8)
      ..lineTo(w * 0.74, h * 0.67)
      ..cubicTo(w * 0.69, h * 0.71, w * 0.61, h * 0.74, w * 0.5, h * 0.74)
      ..cubicTo(w * 0.37, h * 0.74, w * 0.26, h * 0.65, w * 0.22, h * 0.53)
      ..lineTo(w * 0.06, h * 0.53)
      ..lineTo(w * 0.06, h * 0.66)
      ..cubicTo(w * 0.15, h * 0.83, w * 0.31, h * 0.95, w * 0.5, h * 0.95);

    final Path yellowPath = Path()
      ..moveTo(w * 0.22, h * 0.53)
      ..cubicTo(w * 0.2, h * 0.49, w * 0.19, h * 0.45, w * 0.19, h * 0.4)
      ..cubicTo(w * 0.19, h * 0.35, w * 0.2, h * 0.31, w * 0.22, h * 0.27)
      ..lineTo(w * 0.22, h * 0.14)
      ..lineTo(w * 0.06, h * 0.14)
      ..cubicTo(w * 0.02, h * 0.22, 0, h * 0.31, 0, h * 0.4)
      ..cubicTo(0, h * 0.49, w * 0.02, h * 0.58, w * 0.06, h * 0.66)
      ..lineTo(w * 0.22, h * 0.53);

    final Path redPath = Path()
      ..moveTo(w * 0.5, h * 0.19)
      ..cubicTo(w * 0.61, h * 0.19, w * 0.7, h * 0.23, w * 0.77, h * 0.3)
      ..lineTo(w * 0.91, h * 0.16)
      ..cubicTo(w * 0.81, h * 0.06, w * 0.67, 0, w * 0.5, 0)
      ..cubicTo(w * 0.31, 0, w * 0.15, h * 0.11, w * 0.06, h * 0.28)
      ..lineTo(w * 0.22, h * 0.4)
      ..cubicTo(w * 0.26, h * 0.28, w * 0.37, h * 0.19, w * 0.5, h * 0.19);

    canvas.drawPath(bluePath, bluePaint);
    canvas.drawPath(greenPath, greenPaint);
    canvas.drawPath(yellowPath, yellowPaint);
    canvas.drawPath(redPath, redPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
