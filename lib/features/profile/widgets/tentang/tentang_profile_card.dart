import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class TentangProfileCard extends StatelessWidget {
  const TentangProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar + tombol ubah foto
          CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            child: const Icon(
              Icons.person,
              size: 42,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.camera_alt_outlined,
                    size: 12, color: AppColors.primary),
                SizedBox(width: 6),
                Text(
                  "Ubah Foto Profil",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Nama Lengkap
          _buildReadOnlyField(
            context,
            label: "Nama Lengkap",
            value: "Qulbi Khutsi Azzumi",
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 14),

          // Alamat Email (terkunci)
          _buildLockedField(
            context,
            label: "Alamat Email",
            value: "qulbi@hoaxcheck.id",
            icon: Icons.mail_outline,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 12,
                color: isDark
                    ? AppDarkColors.textSecondary
                    : AppColors.neutral,
              ),
              const SizedBox(width: 6),
              Text(
                "Email akun terdaftar tidak dapat diubah",
                style: TextStyle(
                  color: isDark
                      ? AppDarkColors.textSecondary
                      : AppColors.neutral,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Status Literasi
          _buildStatusRow(
            context,
            icon: Icons.workspace_premium_outlined,
            label: "Status Literasi",
            value: "Pengguna Aktif Komunitas",
            color: AppColors.primary,
          ),
          const SizedBox(height: 10),

          // Tingkat Kontributor
          _buildStatusRow(
            context,
            icon: Icons.verified_outlined,
            label: "Tingkat Kontributor",
            value: "Verifikator Independen",
            color: AppColors.tertiary,
          ),
          const SizedBox(height: 20),

          // Tombol Simpan Perubahan
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Perubahan profil disimpan."),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.check, size: 16, color: Colors.white),
              label: const Text(
                "Simpan Perubahan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF047857),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Info privacy
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: isDark
                      ? AppDarkColors.textSecondary
                      : const Color(0xFF64748B),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Informasi profil hanya digunakan secara lokal di perangkat Anda untuk personalisasi pengalaman aplikasi.",
                    style: TextStyle(
                      color: isDark
                          ? AppDarkColors.textSecondary
                          : const Color(0xFF64748B),
                      fontSize: 11,
                      height: 1.4,
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

  Widget _buildReadOnlyField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: isDark ? Colors.white54 : AppColors.neutral,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.inverted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLockedField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.lock,
                  size: 11,
                  color: isDark ? Colors.white54 : AppColors.neutral,
                ),
                const SizedBox(width: 4),
                Text(
                  "Terkunci",
                  style: TextStyle(
                    color: isDark ? Colors.white54 : AppColors.neutral,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppDarkColors.neutral : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: isDark ? Colors.white38 : Colors.grey.shade500,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: isDark ? Colors.white54 : const Color(0xFF64748B),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color:
                      isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.inverted,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}