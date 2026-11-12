import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class NotificationFilterChips extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onFilterChanged;
  final int allCount;
  final int unreadCount;

  const NotificationFilterChips({
    super.key,
    required this.selectedIndex,
    required this.onFilterChanged,
    this.allCount = 0,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        _buildChip(
          context: context,
          isDark: isDark,
          title: "Semua",
          count: "$allCount",
          isSelected: selectedIndex == 0,
          onTap: () => onFilterChanged(0),
        ),
        const SizedBox(width: 12),
        _buildChip(
          context: context,
          isDark: isDark,
          title: "Belum Dibaca",
          count: "$unreadCount",
          isSelected: selectedIndex == 1,
          onTap: () => onFilterChanged(1),
        ),
      ],
    );
  }

  Widget _buildChip({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (isDark ? AppDarkColors.surface : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? AppDarkColors.border : const Color(0xFFE2E8F0)),
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B)),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.25)
                    : (isDark ? Colors.white12 : const Color(0xFFF1F5F9)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white70 : AppColors.inverted),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
