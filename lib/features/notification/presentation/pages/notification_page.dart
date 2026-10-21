import 'package:flutter/material.dart';
import '../widgets/notification_summary_card.dart';
import '../widgets/notification_filter_chips.dart';
import '../widgets/notification_group_header.dart';
import '../widgets/notification_item_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int selectedFilterIndex = 0; // 0: Semua, 1: Belum Dibaca

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifikasi",
          style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NotificationSummaryCard(
              unreadCount: 3,
              subtitle: "Tetap terinformasi & kritis",
            ),
            const SizedBox(height: 20),
            NotificationFilterChips(
              selectedIndex: selectedFilterIndex,
              onFilterChanged: (index) {
                setState(() {
                  selectedFilterIndex = index;
                });
              },
            ),
            const SizedBox(height: 24),
            
            // Grup: Hari Ini
            const NotificationGroupHeader(title: "HARI INI", count: "2 pemberitahuan"),
            const SizedBox(height: 12),
            const NotificationItemCard(
              isUnread: true,
              icon: Icons.article_outlined,
              iconBgColor: Color(0xFFD1FAE5),
              iconColor: Color(0xFF059669),
              title: "Analisis Berhasil",
              time: "5 mnt lalu",
              description: "Pemeriksaan teks yang kamu kirim telah selesai. Lihat hasil analisis untuk...",
              tagLabel: "Verifikasi Teks",
              tagBgColor: Color(0xFFD1FAE5),
              tagTextColor: Color(0xFF059669),
            ),
            const SizedBox(height: 12),
            const NotificationItemCard(
              isUnread: true,
              icon: Icons.lightbulb_outline,
              iconBgColor: Color(0xFFDBEAFE),
              iconColor: Color(0xFF2563EB),
              title: "Tips Mengenali Hoaks",
              time: "2 jam lalu",
              description: "Periksa sumber informasi sebelum membagikannya. Kenali tanda-tanda...",
              tagLabel: "Literasi Digital",
              tagBgColor: Color(0xFFDBEAFE),
              tagTextColor: Color(0xFF2563EB),
            ),
            const SizedBox(height: 24),

            // Grup: Kemarin
            const NotificationGroupHeader(title: "KEMARIN", count: "1 pemberitahuan"),
            const SizedBox(height: 12),
            const NotificationItemCard(
              isUnread: true,
              icon: Icons.verified_outlined,
              iconBgColor: Color(0xFFD1FAE5),
              iconColor: Color(0xFF059669),
              title: "Hasil Pemeriksaan Terse...",
              time: "14:20 WIB",
              description: "Hasil pemeriksaan teks kamu sudah dapat dilihat di halaman Riwayat. Cek...",
              tagLabel: "Klarifikasi Arsip",
              tagBgColor: Color(0xFFD1FAE5),
              tagTextColor: Color(0xFF059669),
            ),
            const SizedBox(height: 24),

            // Grup: Sebelumnya
            const NotificationGroupHeader(title: "SEBELUMNYA", count: "1 pemberitahuan"),
            const SizedBox(height: 12),
            const NotificationItemCard(
              isUnread: false,
              icon: Icons.menu_book_outlined,
              iconBgColor: Color(0xFFF1F5F9),
              iconColor: Color(0xFF64748B),
              title: "Pelajari Literasi Digital",
              time: "3 hari lalu",
              description: "Baca materi edukasi untuk membantu kamu mengevaluasi informasi secara...",
              tagLabel: "Modul Edukasi",
              tagBgColor: Color(0xFFE2E8F0),
              tagTextColor: Color(0xFF475569),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}