import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../../../../app/app_header.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/repositories/history_repository.dart';
import '../../domain/usecases/get_user_history_usecase.dart';
import '../widgets/history_card.dart';
import '../widgets/history_tips_banner.dart';
import '../widgets/history_delete_dialog.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String selectedFilter = 'Semua';
  String searchQuery = '';

  // Clean Architecture: Injeksi UseCase & Repository
  late final HistoryRepository _historyRepository = HistoryRepositoryImpl();
  late final GetUserHistoryUseCase _getUserHistoryUseCase =
      GetUserHistoryUseCase(_historyRepository);

  bool _isLoading = true;
  List<Map<String, dynamic>> historyData = [];

  // Optimasi Lazy Loading & Pagination
  final ScrollController _scrollController = ScrollController();
  int _displayedLimit = 15;
  static const int _pageSize = 15;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchHistoryFromSupabase();
  }

  void _onScroll() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 250) {
      if (_displayedLimit < historyData.length) {
        setState(() {
          _displayedLimit += _pageSize;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchHistoryFromSupabase({bool forceRefresh = false}) async {
    try {
      final items = await _getUserHistoryUseCase(const NoParams(), forceRefresh: forceRefresh);
      if (mounted) {
        setState(() {
          historyData = items.map((item) => item.toMap()).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Info: Gagal memuat riwayat: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder:
          (context) => HistoryDeleteDialog(
            onDeleteAll: () async {
              final messenger = ScaffoldMessenger.of(context);
              setState(() {
                historyData.clear();
              });
              try {
                await _historyRepository.clearAllHistory();
                if (mounted) {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('Semua riwayat berhasil dihapus dari cloud.'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                }
              } catch (e) {
                debugPrint('Info: Gagal menghapus riwayat cloud: $e');
              }
            },
          ),
    );
  }

  void _deleteSingleHistory(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Hapus Riwayat Ini?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Item riwayat ini akan dihapus permanen. Setelah dihapus, berita ini dapat dideteksi kembali.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Batal", style: TextStyle(color: AppColors.neutral)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        historyData.removeWhere((item) => item['id'] == id);
      });
      try {
        await _historyRepository.deleteHistory(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Riwayat berhasil dihapus."),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        debugPrint("Gagal menghapus riwayat: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final int allCount = historyData.length;
    final int hoaxCount = historyData.where((e) => e['isHoax'] == true).length;
    final int validCount =
        historyData.where((e) => e['isHoax'] == false).length;

    List<Map<String, dynamic>> getFilteredData() {
      List<Map<String, dynamic>> list = historyData;

      if (selectedFilter == 'Terindikasi Hoaks') {
        list = list.where((item) => item['isHoax'] == true).toList();
      } else if (selectedFilter == 'Valid') {
        list = list.where((item) => item['isHoax'] == false).toList();
      }

      if (searchQuery.isNotEmpty) {
        list =
            list
                .where(
                  (item) => item['text'].toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ),
                )
                .toList();
      }

      return list;
    }

    final filteredList = getFilteredData();
    final displayedList = filteredList.take(_displayedLimit).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => _fetchHistoryFromSupabase(forceRefresh: true),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHeader(title: "Riwayat"),
                const SizedBox(height: 8), // Dibuat lebih rapat
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    const Text(
                                      "- Data riwayat pemeriksaan akan tersimpan selama 30 hari.\n- Berita dalam riwayat tidak dapat dideteksi ulang sebelum 30 hari atau sebelum dihapus.",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF64748B),
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: _showDeleteDialog,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEE2E2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.delete_outline_rounded,
                                        size: 14,
                                        color: Color(0xFFDC2626),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Hapus",
                                        style: TextStyle(
                                          color: Color(0xFFDC2626),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.trim();
                        _displayedLimit = _pageSize;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Cari riwayat pemeriksaan...",
                      hintStyle: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF64748B),
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Semua', allCount, null),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        'Terindikasi Hoaks',
                        hoaxCount,
                        const Color(0xFFDC2626),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        'Valid',
                        validCount,
                        const Color(0xFF059669),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        ),
                      )
                    : filteredList.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 36),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.history_toggle_off_rounded,
                                    size: 46,
                                    color: isDark
                                        ? AppDarkColors.textSecondary
                                        : const Color(0xFF94A3B8),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    searchQuery.isNotEmpty
                                        ? "Tidak ada riwayat yang cocok"
                                        : "Belum ada riwayat pemeriksaan",
                                    style: TextStyle(
                                      color: isDark
                                          ? AppDarkColors.textPrimary
                                          : AppColors.inverted,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    searchQuery.isNotEmpty
                                        ? "Coba gunakan kata kunci pencarian yang lain."
                                        : "Teks yang kamu periksa akan tersimpan di sini secara otomatis.",
                                    style: TextStyle(
                                      color: isDark
                                          ? AppDarkColors.textSecondary
                                          : const Color(0xFF94A3B8),
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: displayedList.length +
                                (filteredList.length > displayedList.length ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= displayedList.length) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final item = displayedList[index];
                              final itemId = item['id']?.toString();
                              return HistoryCard(
                                id: itemId,
                                isHoax: item['isHoax'],
                                confidence: item['confidence'],
                                time: item['time'],
                                text: item['text'],
                                analysisType: item['analysisType'],
                                source: item['source'],
                                onDelete: itemId != null
                                    ? () => _deleteSingleHistory(itemId)
                                    : null,
                              );
                            },
                          ),
                const SizedBox(height: 8),
                const HistoryTipsBanner(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, int count, Color? dotColor) {
    final bool isSelected = selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
          _displayedLimit = _pageSize;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF059669) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dotColor != null && !isSelected) ...[
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              "$label ($count)",
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF334155),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
