import 'package:flutter/material.dart';

class NotificationFilterChips extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onFilterChanged;

  const NotificationFilterChips({
    super.key,
    required this.selectedIndex,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildChip(
          title: "Semua",
          count: "4",
          isSelected: selectedIndex == 0,
          onTap: () => onFilterChanged(0),
        ),
        const SizedBox(width: 12),
        _buildChip(
          title: "Belum Dibaca",
          count: "3",
          isSelected: selectedIndex == 1,
          onTap: () => onFilterChanged(1),
        ),
      ],
    );
  }

  Widget _buildChip({
    required String title,
    required String count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF047857) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF065F46) : const Color(0xFF047857),
                shape: BoxShape.circle,
              ),
              child: Text(
                count,
                style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}