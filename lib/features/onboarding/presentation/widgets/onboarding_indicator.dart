import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color primaryColor;
  final bool isDark;
  final Function(int) onPageSelected;

  const OnboardingIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.primaryColor,
    required this.isDark,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final bool isActive = currentIndex == index;
        return GestureDetector(
          onTap: () => onPageSelected(index),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 6,
              width: isActive ? 24 : 6,
              decoration: BoxDecoration(
                color: isActive ? primaryColor : (isDark ? Colors.white24 : const Color(0xFFCBD5E1)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      }),
    );
  }
}