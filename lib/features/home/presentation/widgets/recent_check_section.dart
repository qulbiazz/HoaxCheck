import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../detection/presentation/pages/analysis_detail_page.dart';
import '../../../history/data/repositories/history_repository_impl.dart';
import '../../../history/domain/entities/history_item.dart';

class RecentCheckCard extends StatefulWidget {
  final VoidCallback? onNavigateToDetection;
  final VoidCallback? onViewAllPressed;

  const RecentCheckCard({
    super.key,
    this.onNavigateToDetection,
    this.onViewAllPressed,
  });

  @override
  State<RecentCheckCard> createState() => _RecentCheckCardState();
}

class _RecentCheckCardState extends State<RecentCheckCard> {
  HistoryItem? _latestItem;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLatest();
  }

  Future<void> _fetchLatest() async {
    try {
      final items = await HistoryRepositoryImpl().getUserHistories();
      if (mounted) {
        setState(() {
          _latestItem = items.isNotEmpty ? items.first : null;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return const SizedBox.shrink();
    }

    if (_latestItem == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppDarkColors.surface : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_outlined,
              size: 36,
              color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 10),
            Text(
              "Belum Ada Pemeriksaan Terbaru",
              style: TextStyle(
                color: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Periksa pesan atau berita mencurigakan sekarang.",
              style: TextStyle(
                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: widget.onNavigateToDetection,
              icon: const Icon(Icons.auto_awesome, size: 16),
              label: const Text("Mulai Deteksi", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      );
    }

    final item = _latestItem!;
    final isHoax = item.isHoax;
    final statusColor = isHoax ? const Color(0xFFDC2626) : AppColors.primary;
    final statusBg = isHoax ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5);
    final statusText = isHoax ? "Terindikasi\nHoaks" : "Informasi\nValid";

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              final parsedConfidence =
                  int.tryParse(item.confidence.replaceAll('%', '').trim()) ?? 85;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalysisDetailPage(
                    text: item.snippet.isNotEmpty ? item.snippet : item.title,
                    classification: item.analysisType.isNotEmpty
                        ? item.analysisType
                        : (isHoax ? "Terindikasi Hoaks" : "Informasi Valid"),
                    confidence: parsedConfidence,
                    isHoax: isHoax,
                    onNavigateToDetection: widget.onNavigateToDetection,
                  ),
                ),
              );
            },
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(width: 5, color: statusColor),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isHoax
                                          ? Icons.cancel_outlined
                                          : Icons.check_circle_outline,
                                      size: 12,
                                      color: statusColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      statusText,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                        height: 1.1,
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
                                  color: const Color(0xFFDBEAFE),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "${item.confidence}\nKeyakinan",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF1D4ED8),
                                    fontWeight: FontWeight.bold,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                item.time,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppDarkColors.textSecondary
                                      : const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '"${item.snippet.isNotEmpty ? item.snippet : item.title}"',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppDarkColors.textPrimary
                                  : const Color(0xFF0F172A),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.link,
                                size: 14,
                                color: isDark
                                    ? AppDarkColors.textSecondary
                                    : const Color(0xFF94A3B8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Sumber: ${item.source}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppDarkColors.textSecondary
                                      : const Color(0xFF94A3B8),
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                "Detail Analisis",
                                style: TextStyle(
                                  color: Color(0xFF059669),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward,
                                size: 12,
                                color: Color(0xFF059669),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
