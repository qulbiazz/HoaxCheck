import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class PrimaryAuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool hasShadow;

  const PrimaryAuthButton({super.key, required this.label, required this.onPressed, this.hasShadow = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppDarkColors.primary : const Color(0xFF006B4D);

    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: hasShadow && !isDark ? [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8))] : [],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class GoogleAuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const GoogleAuthButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppDarkColors.primary : const Color(0xFF006B4D);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MENGGUNAKAN ASSETS GAMBAR UNTUK LOGO GOOGLE
            Image.asset('assets/images/google.png', width: 22, height: 22), 
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}