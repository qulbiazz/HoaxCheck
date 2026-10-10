import 'package:flutter/material.dart';

class HoaxCheckLogo extends StatelessWidget {
  final double size;
  final double borderRadius;
  final Color backgroundColor;
  final bool showShadow;

  const HoaxCheckLogo({
    super.key,
    this.size = 86,
    this.borderRadius = 22,
    this.backgroundColor = const Color(0xFF006B4D),
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final scale = size / 86.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius * scale),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: backgroundColor.withValues(alpha: 0.3),
                  blurRadius: 20 * scale,
                  offset: Offset(0, 6 * scale),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius * scale),
        child: Image.asset(
          'assets/images/logo.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
