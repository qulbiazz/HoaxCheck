import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class ForgotPasswordFormCard extends StatelessWidget {
  final TextEditingController emailController;
  final VoidCallback onSubmit;
  final bool isLoading;

  const ForgotPasswordFormCard({
    super.key,
    required this.emailController,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppDarkColors.border : const Color(0xFFE2E8F0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : const Color(0xFFF0FDF4),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : const Color(0xFFDCFCE7),
                    width: 4,
                  ),
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  size: 36,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Lupa Password?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Masukkan email yang terdaftar. Jika akun Anda ditemukan, instruksi untuk mengatur ulang password akan dikirimkan sesuai mekanisme pemulihan akun yang tersedia.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Alamat Email",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF334155),
                ),
              ),
              Text(
                "Wajib diisi",
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? AppDarkColors.border : const Color(0xFFE2E8F0),
              ),
            ),
            child: TextField(
              controller: emailController,
              style: TextStyle(
                color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                fontSize: 13.5,
              ),
              decoration: InputDecoration(
                hintText: "nama@email.com",
                hintStyle: TextStyle(
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                  fontSize: 13,
                ),
                prefixIcon: Icon(
                  Icons.mail_outline_rounded,
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                  size: 18,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 13,
                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Pastikan email aktif dan sesuai dengan yang kamu gunakan saat mendaftar di sistem HoaxCheck.",
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.send_rounded, size: 16, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Kirim Instruksi",
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ingat kata sandi Anda? ",
                style: TextStyle(
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                  fontSize: 12,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "Masuk",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppDarkColors.border : const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Proses pemulihan akun terproteksi standar privasi HoaxCheck.",
                    style: TextStyle(
                      fontSize: 10.5,
                      color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}