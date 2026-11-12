import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../data/models/app_info_model.dart';
import 'tentang_shared.dart';

class TentangCaraKerjaSection extends StatelessWidget {
  final List<HowItWorksStepModel>? steps;

  const TentangCaraKerjaSection({super.key, this.steps});

  @override
  Widget build(BuildContext context) {
    final stepsToDisplay = (steps != null && steps!.isNotEmpty)
        ? steps!
        : AppInfoModel.defaultInfo.steps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TentangSectionTitle(
          icon: Icons.settings_suggest_outlined,
          title: "Bagaimana Cara Kerjanya?",
        ),
        const SizedBox(height: 12),
        ...stepsToDisplay.map((step) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildStep(
            context,
            number: step.number,
            icon: step.iconData,
            title: step.title,
            desc: step.description,
          ),
        )),
      ],
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required String number,
    required IconData icon,
    required String title,
    required String desc,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nomor
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 14, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: isDark ? Colors.white : AppColors.inverted,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: TextStyle(
                    color: isDark ? Colors.white70 : AppColors.neutral,
                    fontSize: 11.5,
                    height: 1.45,
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
