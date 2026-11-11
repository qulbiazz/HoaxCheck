import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class ModelInfoCard extends StatelessWidget {
  final String text;
  final int confidence;
  final bool isHoax;
  final String modelName;
  final String trainingParam;

  const ModelInfoCard({
    super.key,
    this.text = '',
    this.confidence = 87,
    this.isHoax = true,
    this.modelName = "Bernoulli Naive Bayes (NB_Bernoulli)",
    this.trainingParam = "Binary Feature Extraction (Presence/Absence)",
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Hitung panjang karakter dan kata secara dinamis
    final trimmed = text.trim();
    final int charCount = text.length;
    final int wordCount = trimmed.isEmpty ? 0 : trimmed.split(RegExp(r'\s+')).length;
    final String textLengthDisplay = "$wordCount kata | $charCount karakter";

    final Color statusColor =
        isHoax ? const Color(0xFFDC2626) : const Color(0xFF047857);
    final String statusText =
        isHoax ? "$confidence% Probabilitas Hoaks" : "$confidence% Probabilitas Valid";

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
              Expanded(
                child: Text(
                  "Informasi Model Machine Learning",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.inverted,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildInfoRow(isDark, "Arsitektur Model", modelName),
          const Divider(height: 18, thickness: 0.5),
          _buildInfoRow(isDark, "Parameter Pelatihan", trainingParam),
          const Divider(height: 18, thickness: 0.5),
          _buildInfoRow(isDark, "Panjang Input Teks", textLengthDisplay),
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
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        statusText,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: statusColor,
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
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
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
