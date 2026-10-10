import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import 'kebijakan_shared.dart';

class KebijakanPerubahan extends StatelessWidget {
  const KebijakanPerubahan({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KebijakanSectionTitle(
          number: "6",
          title: "Perubahan Kebijakan",
          icon: Icons.refresh,
        ),
        const SizedBox(height: 12),
        KebijakanCard(
          child: Text(
            "Kebijakan privasi ini dapat diperbarui sewaktu-waktu seiring dengan pengembangan fitur baru atau penyesuaian praktik penanganan data aplikasi.",
            style: TextStyle(
              color: isDark ? Colors.white70 : AppColors.inverted,
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}