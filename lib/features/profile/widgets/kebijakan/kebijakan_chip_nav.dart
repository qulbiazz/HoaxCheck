import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class KebijakanChipNav extends StatelessWidget {
  final VoidCallback onTapDataDisimpan;
  final VoidCallback onTapPenggunaan;
  final VoidCallback onTapKeamanan;

  const KebijakanChipNav({
    super.key,
    required this.onTapDataDisimpan,
    required this.onTapPenggunaan,
    required this.onTapKeamanan,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip(
            context,
            icon: Icons.storage_outlined,
            label: "Data Disimpan",
            onTap: onTapDataDisimpan,
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            icon: Icons.tune,
            label: "Penggunaan",
            onTap: onTapPenggunaan,
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            icon: Icons.lock_outline,
            label: "Keamanan",
            onTap: onTapKeamanan,
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? AppDarkColors.surface : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.inverted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}