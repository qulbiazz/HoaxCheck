import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class ModelInfoCard extends StatelessWidget {
  const ModelInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.memory_outlined,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                "Informasi Model NLP",
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.inverted,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildInfoRow(isDark, "Arsitektur Model", "IndoBERT Text Classifier v2.4"),
          const Divider(height: 18, thickness: 0.5),
          _buildInfoRow(isDark, "Parameter Pelatihan", "Fine-tuned (Civic News Corpus)"),
          const Divider(height: 18, thickness: 0.5),
          _buildInfoRow(isDark, "Panjang Input Teks", "135 kata | 642 karakter"),
          const Divider(height: 18, thickness: 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status Inferensi",
                style: TextStyle(
                  color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDC2626),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Flexible(
                      child: Text(
                        "87% Probabilitas Anomali",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(bool isDark, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 12), // Memberikan jarak aman antara label dan value
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right, // Menggeser teks ke kanan
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.inverted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}