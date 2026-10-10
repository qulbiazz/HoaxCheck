import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../widgets/kebijakan/kebijakan_hero_card.dart';
import '../widgets/kebijakan/kebijakan_chip_nav.dart';
import '../widgets/kebijakan/kebijakan_data_disimpan.dart';
import '../widgets/kebijakan/kebijakan_riwayat.dart';
import '../widgets/kebijakan/kebijakan_penggunaan_data.dart';
import '../widgets/kebijakan/kebijakan_keamanan_data.dart';
import '../widgets/kebijakan/kebijakan_penghapusan_data.dart';
import '../widgets/kebijakan/kebijakan_perubahan.dart';
import '../widgets/kebijakan/kebijakan_kontak.dart';

class KebijakanPrivasiPage extends StatefulWidget {
  const KebijakanPrivasiPage({super.key});

  @override
  State<KebijakanPrivasiPage> createState() => _KebijakanPrivasiPageState();
}

class _KebijakanPrivasiPageState extends State<KebijakanPrivasiPage> {
  // GlobalKey untuk tiap section → dipakai auto-scroll dari chip navigasi
  final GlobalKey _keyDataDisimpan = GlobalKey();
  final GlobalKey _keyPenggunaan = GlobalKey();
  final GlobalKey _keyKeamanan = GlobalKey();

  /// Auto-scroll ke section berdasarkan GlobalKey
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
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
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          "Kebijakan Privasi",
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.inverted,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero card
              const KebijakanHeroCard(),
              const SizedBox(height: 16),

              // Chip navigasi (auto-scroll)
              KebijakanChipNav(
                onTapDataDisimpan: () => _scrollToSection(_keyDataDisimpan),
                onTapPenggunaan: () => _scrollToSection(_keyPenggunaan),
                onTapKeamanan: () => _scrollToSection(_keyKeamanan),
              ),
              const SizedBox(height: 24),

              // Section 1 — Data yang Disimpan
              Container(
                key: _keyDataDisimpan,
                child: const KebijakanDataDisimpan(),
              ),
              const SizedBox(height: 24),

              // Section 2 — Riwayat Pemeriksaan
              const KebijakanRiwayat(),
              const SizedBox(height: 24),

              // Section 3 — Penggunaan Data (target chip "Penggunaan")
              Container(
                key: _keyPenggunaan,
                child: const KebijakanPenggunaanData(),
              ),
              const SizedBox(height: 24),

              // Section 4 — Keamanan Data (target chip "Keamanan")
              Container(
                key: _keyKeamanan,
                child: const KebijakanKeamananData(),
              ),
              const SizedBox(height: 24),

              // Section 5 — Penghapusan Data
              const KebijakanPenghapusanData(),
              const SizedBox(height: 24),

              // Section 6 — Perubahan Kebijakan
              const KebijakanPerubahan(),
              const SizedBox(height: 24),

              // Section 7 + Footer
              const KebijakanKontak(),
            ],
          ),
        ),
      ),
    );
  }
}