import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../widgets/analysis_header_bar.dart';
import '../widgets/prediction_hero_card.dart';
import '../widgets/detected_indicators_card.dart';
import '../widgets/model_info_card.dart';
import '../widgets/education_card.dart';
import '../widgets/analysis_action_buttons.dart';

class AnalysisDetailPage extends StatelessWidget {
  final VoidCallback? onNavigateToDetection;
  final String analysisId;
  final String classification;
  final int confidence;
  final double analysisTimeSeconds;
  final bool isHoax;

  const AnalysisDetailPage({
    super.key,
    this.analysisId = "#HC-98234",
    this.classification = "Terindikasi Hoaks",
    this.confidence = 87,
    this.analysisTimeSeconds = 1.2,
    this.isHoax = true,
    this.onNavigateToDetection, // Tambahkan baris ini
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color statusColor =
        isHoax ? const Color(0xFFDC2626) : AppColors.primary;
    final Color statusBg =
        isHoax ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5);

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.inverted,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          "Detail Analisis",
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.inverted,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnalysisHeaderBar(
                analysisId: analysisId,
                statusColor: statusColor,
              ),
              const SizedBox(height: 16),
              PredictionHeroCard(
                isHoax: isHoax,
                classification: classification,
                confidence: confidence,
                analysisTimeSeconds: analysisTimeSeconds,
                statusColor: statusColor,
                statusBg: statusBg,
              ),
              const SizedBox(height: 20),
              const DetectedIndicatorsCard(),
              const SizedBox(height: 20),
              const ModelInfoCard(),
              const SizedBox(height: 20),
              const EducationCard(),
              const SizedBox(height: 24),
              const AnalysisActionButtons(),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Sistem deteksi berbasis pembelajaran mesin memiliki margin kesalahan statistik. Tetap lakukan konfirmasi manual melalui media massa terpercaya dan kanal pengecekan fakta independen (CekFakta/TurnBackHoax).",
                  style: TextStyle(
                    color:
                        isDark
                            ? AppDarkColors.textSecondary
                            : const Color(0xFF94A3B8),
                    fontSize: 10,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
