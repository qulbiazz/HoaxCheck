import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../history/domain/entities/history_item.dart';
import '../../data/repositories/detection_repository_impl.dart';
import '../../domain/exceptions/already_detected_exception.dart';
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
    if (_isAnalyzing) return;

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
      // AnalyzeTextUseCase sudah otomatis memvalidasi riwayat duplikat 30 hari & menyimpan riwayat ke cloud
      final result = await _analyzeTextUseCase(text);

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
    } on AlreadyDetectedException catch (e) {
      if (!mounted) return;
      setState(() => _isAnalyzing = false);
      _showAlreadyDetectedDialog(e.existingItem, e.daysAgo, e.remainingDays);
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

  void _showAlreadyDetectedDialog(
    HistoryItem item,
    int daysAgo,
    int remainingDays,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHoax = item.isHoax;
    final statusColor = isHoax ? AppColors.danger : AppColors.primary;
    final statusBg =
        isHoax ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5);
    final statusText = isHoax ? "Terindikasi Hoaks" : "Informasi Valid";
    final parsedConfidence =
        int.tryParse(item.confidence.replaceAll('%', '').trim()) ?? 85;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppDarkColors.surface : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.history_toggle_off_rounded,
                      color: Color(0xFFD97706),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Berita Sudah Pernah Dideteksi",
                          style: TextStyle(
                            color: isDark
                                ? AppDarkColors.textPrimary
                                : AppColors.inverted,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          daysAgo == 0
                              ? "Diperiksa hari ini"
                              : "Diperiksa $daysAgo hari yang lalu",
                          style: const TextStyle(
                            color: AppColors.neutral,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isHoax
                                    ? Icons.warning_amber_rounded
                                    : Icons.check_circle,
                                color: statusColor,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                statusText,
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${item.confidence} Keyakinan",
                            style: const TextStyle(
                              color: Color(0xFF3730A3),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.snippet,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark
                            ? AppDarkColors.textSecondary
                            : const Color(0xFF475569),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Color(0xFFD97706),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Berita ini tidak dapat dideteksi ulang karena masih tersimpan di riwayat dalam batas 30 hari. Hapus dari riwayat jika ingin menganalisis ulang sekarang.",
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AnalysisDetailPage(
                          text: item.snippet,
                          classification: item.analysisType.isNotEmpty
                              ? item.analysisType
                              : statusText,
                          confidence: parsedConfidence,
                          isHoax: item.isHoax,
                          indicators: item.isHoax
                              ? const [
                                  "Karakteristik teks berita tidak terverifikasi",
                                  "Pola pesan berantai terdeteksi",
                                ]
                              : const [
                                  "Struktur teks informatif dan objektif",
                                  "Tidak terdeteksi unsur fabrikasi informasi",
                                ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text(
                    "Buka Hasil Sebelumnya",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF047857),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (item.id != null) ...[
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      Navigator.pop(ctx);
                      try {
                        await _detectionRepository.deleteHistoryById(item.id!);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Riwayat lama dihapus. Memulai deteksi baru...",
                              ),
                              backgroundColor: AppColors.primary,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          _handleAnalyze();
                        }
                      } catch (e) {
                        debugPrint("Gagal menghapus riwayat lama: $e");
                      }
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Color(0xFFDC2626),
                    ),
                    label: const Text(
                      "Hapus dari Riwayat & Deteksi Ulang",
                      style: TextStyle(
                        color: Color(0xFFDC2626),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFECACA)),
                      backgroundColor: isDark
                          ? const Color(0xFF7F1D1D).withValues(alpha: 0.15)
                          : const Color(0xFFFEF2F2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    "Tutup",
                    style: TextStyle(
                      color: isDark ? Colors.white70 : AppColors.neutral,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
