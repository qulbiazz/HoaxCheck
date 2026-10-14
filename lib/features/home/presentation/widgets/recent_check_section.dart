import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../detection/presentation/pages/analysis_detail_page.dart';

class RecentCheckCard extends StatelessWidget {
  final VoidCallback? onNavigateToDetection;

  const RecentCheckCard({super.key, this.onNavigateToDetection, VoidCallback? onViewAllPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalysisDetailPage(
                    onNavigateToDetection: onNavigateToDetection,
                  ),
                ),
              );
            },
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(width: 5, color: const Color(0xFFDC2626)),
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
                                  color: const Color(0xFFFEE2E2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.cancel_outlined,
                                      size: 12,
                                      color: Color(0xFFDC2626),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Terindikasi\nHoaks",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFFDC2626),
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
                                child: const Text(
                                  "87%\nKeyakinan",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF1D4ED8),
                                    fontWeight: FontWeight.bold,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "Hari ini, 10:42 WIB",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '"Kemenkes bagikan subsidi suplemen gratis lewat link Telegram dengan syarat isi data NIK..."',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.link,
                                size: 14,
                                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Sumber: Tangkapan Layar Pesan",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
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