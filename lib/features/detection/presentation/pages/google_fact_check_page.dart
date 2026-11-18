import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../app/theme.dart';
import '../../data/repositories/fact_check_repository_impl.dart';
import '../../domain/entities/fact_check_entity.dart';
import '../../domain/usecases/search_fact_check_usecase.dart';

class GoogleFactCheckPage extends StatefulWidget {
  final String? initialQuery;

  const GoogleFactCheckPage({super.key, this.initialQuery});

  @override
  State<GoogleFactCheckPage> createState() => _GoogleFactCheckPageState();
}

class _GoogleFactCheckPageState extends State<GoogleFactCheckPage> {
  final TextEditingController _searchController = TextEditingController();
  late final SearchFactCheckUseCase _searchUseCase;

  List<FactCheckEntity> _results = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasSearched = false;

  final List<String> _quickTopics = [
    "Vaksin Booster",
    "Bansos Tunai",
    "Subsidi Kuota",
    "Gempa BMKG",
    "Pajak Sembako",
  ];

  @override
  void initState() {
    super.initState();
    _searchUseCase = SearchFactCheckUseCase(FactCheckRepositoryImpl());

    if (widget.initialQuery != null && widget.initialQuery!.trim().isNotEmpty) {
      _searchController.text = widget.initialQuery!.trim();
      _performSearch(widget.initialQuery!.trim());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _hasSearched = true;
    });

    try {
      final claims = await _searchUseCase(trimmed);
      if (mounted) {
        setState(() {
          _results = claims;
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
              content: Text('Tidak dapat membuka tautan rujukan: $url'),
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
      return const Color(0xFFDC2626);
    } else if (lower.contains('benar') ||
        lower.contains('true') ||
        lower.contains('valid')) {
      return const Color(0xFF16A34A);
    } else {
      return const Color(0xFFD97706);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF4285F4).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.fact_check_rounded,
                color: Color(0xFF4285F4),
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Google Fact Check",
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.inverted,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input Bar
            Container(
              color: isDark ? AppDarkColors.surface : Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: _performSearch,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white : AppColors.inverted,
                          ),
                          decoration: InputDecoration(
                            hintText: "Cari klaim, isu, atau berita hoaks...",
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color(0xFF4285F4),
                              size: 20,
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, size: 18),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {});
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : const Color(0xFFF1F5F9),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () => _performSearch(_searchController.text),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A73E8),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                "Cari",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Quick Topic Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _quickTopics.map((topic) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              _searchController.text = topic;
                              _performSearch(topic);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.08)
                                    : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white12
                                      : const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Text(
                                topic,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? Colors.white70
                                      : const Color(0xFF475569),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Results List
            Expanded(
              child: _isLoading
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF1A73E8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            "Menghubungi Google Fact Check Tools API...",
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppDarkColors.textSecondary
                                  : AppColors.neutral,
                            ),
                          ),
                        ],
                      ),
                    )
                  : _errorMessage != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 40,
                                  color: Color(0xFFDC2626),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Gagal melakukan pencarian",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: isDark ? Colors.white : AppColors.inverted,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.neutral,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : !_hasSearched
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4285F4)
                                            .withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.travel_explore_rounded,
                                        size: 48,
                                        color: Color(0xFF1A73E8),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Periksa Fakta Langsung dari Google",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: isDark ? Colors.white : AppColors.inverted,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Ketik kata kunci isu atau pilih topik populer di atas untuk menelusuri arsip cek fakta dari Mafindo, Kompas, CekFakta, dan media kredibel lainnya.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1.45,
                                        color: isDark
                                            ? AppDarkColors.textSecondary
                                            : AppColors.neutral,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : _results.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(32),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.search_off_rounded,
                                          size: 44,
                                          color: AppColors.neutral,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          "Tidak ditemukan hasil cek fakta",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: isDark
                                                ? Colors.white
                                                : AppColors.inverted,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Coba ubah kata kunci dengan kalimat yang lebih spesifik atau topik berita utama.",
                                          textAlign: TextAlign.center,
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
                              : ListView.builder(
                                  padding: const EdgeInsets.all(16),
                                  itemCount: _results.length,
                                  itemBuilder: (context, index) {
                                    final item = _results[index];
                                    final ratingColor =
                                        _getRatingColor(item.rating);

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? AppDarkColors.surface
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: isDark
                                              ? Colors.white10
                                              : const Color(0xFFE2E8F0),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: isDark
                                                              ? Colors.white
                                                              : AppColors
                                                                  .inverted,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 3,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: ratingColor.withValues(
                                                      alpha: 0.12),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                    color: ratingColor
                                                        .withValues(alpha: 0.3),
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
                                          const SizedBox(height: 10),
                                          Text(
                                            item.reviewTitle,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 1.35,
                                              color: isDark
                                                  ? Colors.white
                                                  : AppColors.inverted,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "Klaim: \"${item.claimText}\"",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                              color: isDark
                                                  ? AppDarkColors.textSecondary
                                                  : AppColors.neutral,
                                            ),
                                          ),
                                          if (item.claimant != null &&
                                              item.claimant!.isNotEmpty) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              "Sumber beredar: ${item.claimant}",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: isDark
                                                    ? AppDarkColors.textSecondary
                                                    : AppColors.neutral,
                                              ),
                                            ),
                                          ],
                                          const SizedBox(height: 12),
                                          if (item.reviewUrl.isNotEmpty)
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton.icon(
                                                onPressed: () =>
                                                    _openFactCheckUrl(
                                                        item.reviewUrl),
                                                icon: const Icon(
                                                  Icons.open_in_new,
                                                  size: 14,
                                                  color: Color(0xFF1A73E8),
                                                ),
                                                label: const Text(
                                                  "Buka Artikel Sumber",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF1A73E8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
            ),
          ],
        ),
      ),
    );
  }
}

