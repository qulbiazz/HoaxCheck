import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../widgets/notification_summary_card.dart';
import '../widgets/notification_filter_chips.dart';
import '../widgets/notification_group_header.dart';
import '../widgets/notification_item_card.dart';

class NotificationPage extends StatefulWidget {
  final NotificationRepository? repository;

  const NotificationPage({super.key, this.repository});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final NotificationRepository _repository;
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  int _selectedFilterIndex = 0; // 0: Semua, 1: Belum Dibaca

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? NotificationRepositoryImpl();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => _isLoading = true);
    try {
      final items = await _repository.getNotifications();
      if (mounted) {
        setState(() {
          _notifications = items;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _markItemAsRead(NotificationModel item) async {
    if (!item.isUnread) return;

    // Optimistic update di UI
    setState(() {
      _notifications = _notifications.map((n) {
        if (n.id == item.id) {
          return n.copyWith(isUnread: false);
        }
        return n;
      }).toList();
    });

    await _repository.markAsRead(item.id);
  }

  Future<void> _markAllAsRead() async {
    setState(() {
      _notifications = _notifications.map((n) => n.copyWith(isUnread: false)).toList();
    });

    await _repository.markAllAsRead();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua notifikasi telah ditandai dibaca."),
          backgroundColor: AppColors.primary,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showNotificationDetail(NotificationModel item) {
    _markItemAsRead(item);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white24 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item.iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, size: 22, color: item.iconColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: item.tagBgColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item.tagLabel,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: item.tagTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.displayTime,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.inverted,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Tutup",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final unreadCount = _notifications.where((n) => n.isUnread).length;
    final allCount = _notifications.length;

    final filteredList = _selectedFilterIndex == 1
        ? _notifications.where((n) => n.isUnread).toList()
        : _notifications;

    // Kelompokkan notifikasi berdasarkan kategori waktu ("HARI INI", "KEMARIN", "SEBELUMNYA")
    final Map<String, List<NotificationModel>> grouped = {};
    for (final item in filteredList) {
      final group = item.groupCategory;
      grouped.putIfAbsent(group, () => []).add(item);
    }

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.inverted,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notifikasi",
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.inverted,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh_rounded,
              color: isDark ? Colors.white70 : AppColors.inverted,
              size: 20,
            ),
            tooltip: "Segarkan",
            onPressed: _loadNotifications,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadNotifications,
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationSummaryCard(
                unreadCount: unreadCount,
                subtitle: unreadCount > 0
                    ? "Tetap terinformasi & waspada hoaks"
                    : "Semua informasi sudah kamu baca",
                onMarkAllRead: unreadCount > 0 ? _markAllAsRead : null,
              ),
              const SizedBox(height: 20),
              NotificationFilterChips(
                selectedIndex: _selectedFilterIndex,
                allCount: allCount,
                unreadCount: unreadCount,
                onFilterChanged: (index) {
                  setState(() {
                    _selectedFilterIndex = index;
                  });
                },
              ),
              const SizedBox(height: 24),

              if (_isLoading) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
              ] else if (filteredList.isEmpty) ...[
                _buildEmptyState(isDark),
              ] else ...[
                for (final entry in grouped.entries) ...[
                  NotificationGroupHeader(
                    title: entry.key,
                    count: "${entry.value.length} pemberitahuan",
                  ),
                  const SizedBox(height: 12),
                  for (final item in entry.value) ...[
                    NotificationItemCard(
                      isUnread: item.isUnread,
                      icon: item.icon,
                      iconBgColor: item.iconBgColor,
                      iconColor: item.iconColor,
                      title: item.title,
                      time: item.displayTime,
                      description: item.description,
                      tagLabel: item.tagLabel,
                      tagBgColor: item.tagBgColor,
                      tagTextColor: item.tagTextColor,
                      onTap: () => _showNotificationDetail(item),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 16),
                ],
              ],
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    final isFilteringUnread = _selectedFilterIndex == 1;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppDarkColors.surface : Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Color(0x05000000), blurRadius: 10, offset: Offset(0, 4)),
                ],
              ),
              child: Icon(
                isFilteringUnread
                    ? Icons.mark_email_read_outlined
                    : Icons.notifications_none_rounded,
                size: 48,
                color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isFilteringUnread
                  ? "Semua Notifikasi Sudah Dibaca"
                  : "Belum Ada Pemberitahuan",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.inverted,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isFilteringUnread
                  ? "Tidak ada notifikasi baru yang belum kamu baca saat ini."
                  : "Alert hoaks viral, hasil verifikasi teks, dan tanggapan tim akan muncul di sini.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
