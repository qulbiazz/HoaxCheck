import 'package:flutter/material.dart';

import '../../../../app/theme.dart';

class PrivacyHeader extends StatelessWidget {
  const PrivacyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, size: 18, color: AppColors.inverted),
                ),
                const SizedBox(width: 12),
                Text(
                  "Kebijakan Privasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.inverted,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Bagaimana HoaxCheck mengelola data Anda",
          style: TextStyle(fontSize: 13, color: Color(0xFF334155), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Row(
          children: const [
            Icon(Icons.access_time, size: 12, color: Color(0xFF64748B)),
            SizedBox(width: 4),
            Text(
              "Terakhir diperbarui: Oktober 2026",
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ],
    );
  }
}