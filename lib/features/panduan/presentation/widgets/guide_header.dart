import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class GuideHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onRefresh;

  const GuideHeader({super.key, this.onRefresh});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Tips Literasi Kritis',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
        ),
      ),
      actions: [
        if (onRefresh != null)
          IconButton(
            icon: Icon(Icons.refresh_rounded, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A)),
            tooltip: 'Muat Ulang',
            onPressed: onRefresh,
          ),
      ],
    );
  }
}
