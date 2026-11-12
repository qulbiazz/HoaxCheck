import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class NotificationSummaryCard extends StatelessWidget {
  final int unreadCount;
  final String subtitle;
  final VoidCallback? onMarkAllRead;

  const NotificationSummaryCard({
    super.key,
    required this.unreadCount,
    required this.subtitle,
    this.onMarkAllRead,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppDarkColors.border : const Color(0xFFF1F5F9),
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x05000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: unreadCount > 0
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : (isDark ? Colors.white12 : const Color(0xFFE2E8F0)),
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: unreadCount > 0
                    ? AppColors.primary
                    : (isDark ? Colors.white38 : const Color(0xFF94A3B8)),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unreadCount > 0
                      ? "$unreadCount belum dibaca"
                      : "Semua sudah dibaca",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          if (unreadCount > 0 && onMarkAllRead != null)
            GestureDetector(
              onTap: onMarkAllRead,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.done_all, size: 14, color: AppColors.primary),
                    SizedBox(width: 4),
                    Text(
                      "Tandai Semua",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
