import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFF4F7FF), // PERBAIKAN Latar ikon
                shape: BoxShape.circle
              ),
              child: Icon(icon, size: 18, color: isDark ? Colors.white70 : const Color(0xFF374151)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PERBAIKAN: Ambil warna teks dari tema
                  Text(title, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 13, fontWeight: FontWeight.bold)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: TextStyle(color: isDark ? Colors.white54 : Colors.grey, fontSize: 11)),
                  ]
                ],
              ),
            ),
            if (trailing != null) trailing!
            else Icon(Icons.chevron_right, color: isDark ? Colors.white54 : Colors.grey, size: 20)
          ],
        ),
      ),
    );
  }
}