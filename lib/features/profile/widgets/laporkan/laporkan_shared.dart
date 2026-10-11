import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

/// Label field form (contoh: "Jenis Masalah" + badge "Wajib"/"Opsional")
class LaporkanFieldLabel extends StatelessWidget {
  final String label;
  final String? badge;
  final Color? badgeColor;
  final Color? badgeBgColor;

  const LaporkanFieldLabel({
    super.key,
    required this.label,
    this.badge,
    this.badgeColor,
    this.badgeBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.inverted,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: badgeBgColor ??
                  (badge == "Wajib"
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : (isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFFF1F5F9))),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badge!,
              style: TextStyle(
                color: badgeColor ??
                    (badge == "Wajib"
                        ? AppColors.primary
                        : (isDark
                            ? AppDarkColors.textSecondary
                            : AppColors.neutral)),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

/// Container input field dengan border halus.
class LaporkanFieldContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const LaporkanFieldContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
        ),
      ),
      child: child,
    );
  }
}