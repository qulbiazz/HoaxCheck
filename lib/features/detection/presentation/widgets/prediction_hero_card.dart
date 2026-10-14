import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class PredictionHeroCard extends StatelessWidget {
  final bool isHoax;
  final String classification;
  final int confidence;
  final double analysisTimeSeconds;
  final Color statusColor;
  final Color statusBg;

  const PredictionHeroCard({
    super.key,
    required this.isHoax,
    required this.classification,
    required this.confidence,
    required this.analysisTimeSeconds,
    required this.statusColor,
    required this.statusBg,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isHoax ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                  size: 14,
                  color: statusColor,
                ),
                const SizedBox(width: 6),
                Text(
                  classification,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: confidence / 100,
                    strokeWidth: 8,
                    backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFF1F5F9),
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$confidence%",
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.inverted,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Confidence",
                      style: TextStyle(
                        color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Tingkat Keyakinan Model IndoBERT",
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.inverted,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            "Klasifikasi probabilitas mengindikasikan struktur pesan manipulatif secara signifikan.",
            style: TextStyle(
              color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
              fontSize: 12,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 13,
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                ),
                const SizedBox(width: 6),
                Text(
                  "Dianalisis dalam $analysisTimeSeconds detik",
                  style: TextStyle(
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}