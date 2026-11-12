import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class NotificationGroupHeader extends StatelessWidget {
  final String title;
  final String count;

  const NotificationGroupHeader({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          count,
          style: TextStyle(
            fontSize: 11,
            color: color,
          ),
        ),
      ],
    );
  }
}
