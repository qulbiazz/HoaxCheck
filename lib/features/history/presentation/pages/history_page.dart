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

  @override
  void initState() {
    super.initState();
    _fetchHistoryFromSupabase();
  }

  Future<void> _fetchHistoryFromSupabase() async {
    try {
      final items = await _getUserHistoryUseCase(const NoParams());
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

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                                      "- Data riwayat pemeriksaan akan hilang setelah 30 hari.\n - Arsip analisis teks yang pernah kamu lakukan.",
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
                        : Column(
                      children:
                          filteredList.map((item) {
                            return HistoryCard(
                              isHoax: item['isHoax'],
                              confidence: item['confidence'],
                              time: item['time'],
                              text: item['text'],
                              analysisType: item['analysisType'],
                              source: item['source'],
                            );
                          }).toList(),
                    ),
                const SizedBox(height: 8),
                const HistoryTipsBanner(),
                const SizedBox(height: 100),
              ],
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
