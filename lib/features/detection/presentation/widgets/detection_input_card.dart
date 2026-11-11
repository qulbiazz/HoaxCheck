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
              Row(
                children: [
                  Text(
                    "Teks yang ingin\ndiperiksa",
                    style: TextStyle(
                      color: isDark
                          ? AppDarkColors.textPrimary
                          : AppColors.inverted,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
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
              Row(
                children: [
                  _buildActionText(
                    Icons.clear_all,
                    "Bersihkan",
                    AppColors.neutral,
                  ),
                ],
              )
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
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            size: 12,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Model AI & Heuristik Aktif",
                            style: TextStyle(
                              color: isDark
                                  ? AppDarkColors.textSecondary
                                  : AppColors.inverted,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${widget.controller.text.length} / 2000 karakter",
                        style: const TextStyle(
                          color: AppColors.neutral,
                          fontSize: 10,
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
                        Text(
                          "Menganalisis Konten...",
                          style: TextStyle(
                            color: AppColors.surface,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.auto_awesome,
                          size: 18,
                          color: AppColors.surface,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Periksa Sekarang",
                          style: TextStyle(
                            color: AppColors.surface,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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
