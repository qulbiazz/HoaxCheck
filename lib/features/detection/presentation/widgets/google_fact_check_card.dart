import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../app/theme.dart';
import '../../data/repositories/fact_check_repository_impl.dart';
import '../../domain/entities/fact_check_entity.dart';
import '../../domain/usecases/search_fact_check_usecase.dart';

class GoogleFactCheckCard extends StatefulWidget {
  final String queryText;
  final bool isHoax;

  const GoogleFactCheckCard({
    super.key,
    required this.queryText,
    this.isHoax = false,
  });

  @override
  State<GoogleFactCheckCard> createState() => _GoogleFactCheckCardState();
}

class _GoogleFactCheckCardState extends State<GoogleFactCheckCard> {
  late final SearchFactCheckUseCase _searchFactCheckUseCase;
  List<FactCheckEntity> _factChecks = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _searchFactCheckUseCase = SearchFactCheckUseCase(FactCheckRepositoryImpl());
    _fetchFactChecks();
  }

  Future<void> _fetchFactChecks() async {
    if (widget.queryText.trim().isEmpty) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _factChecks = [];
        });
      }
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await _searchFactCheckUseCase(widget.queryText);
      if (mounted) {
        setState(() {
          _factChecks = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _openFactCheckUrl(String url) async {
    if (url.trim().isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri != null) {
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tidak dapat membuka tautan: $url'),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      }
    }
  }

  Color _getRatingColor(String rating) {
    final lower = rating.toLowerCase();
    if (lower.contains('salah') ||
        lower.contains('hoax') ||
        lower.contains('hoaks') ||
        lower.contains('false') ||
        lower.contains('palsu') ||
        lower.contains('keliru')) {
      return const Color(0xFFDC2626); // Merah
    } else if (lower.contains('benar') ||
        lower.contains('true') ||
        lower.contains('valid')) {
      return const Color(0xFF16A34A); // Hijau
    } else {
      return const Color(0xFFD97706); // Kuning/Oranye
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Google Fact Check
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.fact_check_rounded,
                  color: Color(0xFF4285F4),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Google Fact Check",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.inverted,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4285F4).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Tools API",
                            style: TextStyle(
                              color: Color(0xFF1A73E8),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Klarifikasi dari media & pemeriksa fakta resmi",
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? AppDarkColors.textSecondary
                            : AppColors.neutral,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 16),

          // Konten Hasil Cek Fakta
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Mencocokkan dengan basis data Google Fact Check...",
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppDarkColors.textSecondary
                            : AppColors.neutral,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (_errorMessage != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Tidak dapat memuat klarifikasi Google Fact Check: $_errorMessage",
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB91C1C),
                ),
              ),
            )
          else if (_factChecks.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: AppColors.neutral,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Belum Ada Klaim Identik Tercatat",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppColors.inverted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Teks ini belum memiliki sanggahan langsung di basis data Google Fact Check Tools. Tetap waspada terhadap informasi yang tidak memiliki sumber terpercaya.",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppDarkColors.textSecondary
                          : AppColors.neutral,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: _factChecks.map((item) {
                final ratingColor = _getRatingColor(item.rating);

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.04)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Publisher & Rating Tag
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.verified,
                                  size: 14,
                                  color: Color(0xFF1A73E8),
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    item.publisherName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? Colors.white
                                          : AppColors.inverted,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: ratingColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: ratingColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              item.rating,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: ratingColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Judul Klarifikasi Fakta
                      Text(
                        item.reviewTitle,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                          color: isDark ? Colors.white : AppColors.inverted,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Klaim Asli
                      Text(
                        "Klaim: \"${item.claimText}\"",
                        style: TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: isDark
                              ? AppDarkColors.textSecondary
                              : AppColors.neutral,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Link Baca Klarifikasi
                      if (item.reviewUrl.isNotEmpty)
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => _openFactCheckUrl(item.reviewUrl),
                            borderRadius: BorderRadius.circular(6),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    "Buka Klarifikasi Lengkap",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1A73E8),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.open_in_new,
                                    size: 12,
                                    color: Color(0xFF1A73E8),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

