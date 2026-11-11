import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../data/repositories/detection_repository_impl.dart';
import '../../domain/usecases/analyze_text_usecase.dart';
import '../pages/analysis_detail_page.dart';

class DetectionInputCard extends StatefulWidget {
  final TextEditingController controller;

  const DetectionInputCard({super.key, required this.controller});

  @override
  State<DetectionInputCard> createState() => _DetectionInputCardState();
}

class _DetectionInputCardState extends State<DetectionInputCard> {
  final _detectionRepository = DetectionRepositoryImpl();
  late final _analyzeTextUseCase = AnalyzeTextUseCase(_detectionRepository);
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  Future<void> _handleAnalyze() async {
    final text = widget.controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukkan teks berita atau pesan terlebih dahulu."),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    setState(() => _isAnalyzing = true);

    try {
      final result = await _analyzeTextUseCase(text);

      // Simpan riwayat secara asinkron ke Supabase Cloud
      try {
        await _detectionRepository.saveDetectionToCloud(result);
      } catch (e) {
        debugPrint('Info simpan cloud: $e');
      }

      if (!mounted) return;
      setState(() => _isAnalyzing = false);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AnalysisDetailPage(
            text: text,
            analysisId: result.analysisId,
            classification: result.status,
            confidence: (result.confidenceScore * 100).toInt(),
            analysisTimeSeconds: result.analysisTimeSeconds,
            isHoax: result.isHoax,
            indicators: result.indicators,
            explanation: result.explanation,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        setState(() => _isAnalyzing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal menganalisis teks: $e"),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Teks yang ingin diperiksa",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isDark
                              ? AppDarkColors.textPrimary
                              : AppColors.inverted,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.info_outline,
                      size: 14,
                      color: AppColors.neutral,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildActionText(
                Icons.clear_all,
                "Bersihkan",
                AppColors.neutral,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppDarkColors.neutral : AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                TextField(
                  controller: widget.controller,
                  maxLines: 5,
                  maxLength: 2000,
                  buildCounter: (
                    context, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) =>
                      null, // Hide default counter
                  style: TextStyle(
                    color: isDark
                        ? AppDarkColors.textPrimary
                        : AppColors.inverted,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Masukkan teks atau link di sini...",
                    hintStyle: TextStyle(
                      color: AppColors.neutral,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    filled: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              size: 12,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                "Model NB_Bernoulli Aktif",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDark
                                      ? AppDarkColors.textSecondary
                                      : AppColors.inverted,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${widget.controller.text.length} / 2000",
                        style: const TextStyle(
                          color: AppColors.neutral,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isAnalyzing ? null : _handleAnalyze,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF047857),
                disabledBackgroundColor: const Color(0xFF047857).withValues(alpha: 0.6),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isAnalyzing
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.surface,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "Menganalisis Konten...",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.surface,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.auto_awesome,
                          size: 18,
                          color: AppColors.surface,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            "Periksa Sekarang",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.surface,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionText(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        widget.controller.clear();
      },
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
