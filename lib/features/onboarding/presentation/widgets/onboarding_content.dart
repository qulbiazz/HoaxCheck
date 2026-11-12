import 'package:flutter/material.dart';

class OnboardingItem {
  final String stepText;
  final String categoryPill;
  final IconData categoryIcon;
  final String title;
  final String description;
  final String imagePath;
  final Widget? customFeatureWidget;

  OnboardingItem({
    required this.stepText,
    required this.categoryPill,
    required this.categoryIcon,
    required this.title,
    required this.description,
    required this.imagePath,
    this.customFeatureWidget,
  });
}

class OnboardingContent extends StatelessWidget {
  final OnboardingItem item;
  final bool isDark;
  final Color primaryColor;

  const OnboardingContent({
    super.key,
    required this.item,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.38,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEEF7F6),
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Gambar tidak ditemukan'));
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? primaryColor.withValues(alpha: 0.2) : const Color(0xFFD1FAE5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.categoryIcon, size: 15, color: primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    item.categoryPill,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.25,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: isDark ? Colors.white70 : const Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 24),
            if (item.customFeatureWidget != null) item.customFeatureWidget!,
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}