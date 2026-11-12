import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../../data/datasources/policy_remote_data_source.dart';
import '../../data/models/policy_model.dart';
import '../widgets/kebijakan/kebijakan_chip_nav.dart';
import '../widgets/kebijakan/kebijakan_data_disimpan.dart';
import '../widgets/kebijakan/kebijakan_hero_card.dart';
import '../widgets/kebijakan/kebijakan_keamanan_data.dart';
import '../widgets/kebijakan/kebijakan_kontak.dart';
import '../widgets/kebijakan/kebijakan_penggunaan_data.dart';
import '../widgets/kebijakan/kebijakan_penghapusan_data.dart';
import '../widgets/kebijakan/kebijakan_perubahan.dart';
import '../widgets/kebijakan/kebijakan_riwayat.dart';

class KebijakanPrivasiPage extends StatefulWidget {
  const KebijakanPrivasiPage({super.key});

  @override
  State<KebijakanPrivasiPage> createState() => _KebijakanPrivasiPageState();
}

class _KebijakanPrivasiPageState extends State<KebijakanPrivasiPage> {
  // GlobalKey untuk auto-scroll dari chip navigasi
  final GlobalKey _keyDataDisimpan = GlobalKey();
  final GlobalKey _keyPenggunaan = GlobalKey();
  final GlobalKey _keyKeamanan = GlobalKey();

  // State untuk data dari Supabase
  bool _isLoading = true;
  String? _errorMessage;
  PolicyModel? _privacyPolicy;

  @override
  void initState() {
    super.initState();
    _fetchPolicyData();
  }

  // Fungsi untuk mengambil data dari Supabase
  Future<void> _fetchPolicyData() async {
    try {
      final dataSource = PolicyRemoteDataSourceImpl();
      final result = await dataSource.getPolicyByType('privacy');

      if (mounted) {
        setState(() {
          _privacyPolicy = result;
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
        child: _isLoading
            // 1. Tampilan saat loading
            ? const Center(child: CircularProgressIndicator())
            // 2. Tampilan saat error (misal tabel belum dibuat)
            : _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Gagal memuat data:\n$_errorMessage',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.danger),
                      ),
                    ),
                  )
                // 3. Tampilan utama jika data berhasil diambil
                : SingleChildScrollView(
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

                        // ========================================================
                        // BAGIAN DINAMIS DARI SUPABASE
                        // ========================================================
                        Container(
                          key: _keyDataDisimpan,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _privacyPolicy?.title ?? "Kebijakan Privasi",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : AppColors.inverted,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark ? AppDarkColors.surface : AppColors.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
                                  ),
                                ),
                                child: Text(
                                  _privacyPolicy?.content ?? 
                                    "Data tidak ditemukan di database. Silakan hubungi admin untuk mengisi teks kebijakan privasi.",
                                  style: TextStyle(
                                    color: isDark ? Colors.white70 : AppColors.inverted,
                                    fontSize: 12.5,
                                    height: 1.55,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // ========================================================

                        // Widget statis (desain lama tetap dipertahankan)
                        const KebijakanRiwayat(),
                        const SizedBox(height: 24),

                        Container(
                          key: _keyPenggunaan,
                          child: const KebijakanPenggunaanData(),
                        ),
                        const SizedBox(height: 24),

                        Container(
                          key: _keyKeamanan,
                          child: const KebijakanKeamananData(),
                        ),
                        const SizedBox(height: 24),

                        const KebijakanPenghapusanData(),
                        const SizedBox(height: 24),

                        const KebijakanPerubahan(),
                        const SizedBox(height: 24),

                        const KebijakanKontak(),
                      ],
                    ),
                  ),
      ),
    );
  }
}