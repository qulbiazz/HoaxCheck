import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

import '../widgets/history_header.dart';
import '../widgets/history_search_filter.dart';
import '../widgets/history_card.dart';
import '../widgets/history_tips_banner.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HistoryHeader(),
                const SizedBox(height: 20),
                
                const HistorySearchFilter(),
                const SizedBox(height: 24),
                
                // Daftar Riwayat (Di sini Anda bisa menggunakan ListView.builder jika datanya dari API/Model)
                const HistoryCard(
                  isHoax: true,
                  confidence: "87%",
                  time: "Hari ini, 10:42 WIB",
                  text: "Beredar pesan berantai mengklaim vaksinasi booster gratis dibatalkan pemerintah dan...",
                  analysisType: "Analisis NLP",
                  source: "WhatsApp Forward",
                ),
                const HistoryCard(
                  isHoax: false,
                  confidence: "94%",
                  time: "Kemarin, 15:20 WIB",
                  text: "BMKG merilis peringatan dini potensi hujan lebat disertai kilat di wilayah Jabodetabek pada...",
                  analysisType: "Terverifikasi Sumber",
                  source: "Portal Berita",
                ),
                const HistoryCard(
                  isHoax: true,
                  confidence: "91%",
                  time: "14 Okt 2026, 09:15 WIB", // Menggunakan tahun dinamis sesuai request sistem
                  text: "Membagikan link subsidi kuota internet 100GB mengatasnamakan Kemendikbudristek melalui...",
                  analysisType: "Phishing / Manipulasi",
                  source: "Tautan URL",
                ),
                const HistoryCard(
                  isHoax: false,
                  confidence: "89%",
                  time: "12 Okt 2026, 18:05 WIB",
                  text: "Kementerian Perhubungan mengumumkan penyesuaian tarif LRT Jabodebek per 1...",
                  analysisType: "Media Kredibel",
                  source: "Siaran Pers Resmi",
                ),
                
                const SizedBox(height: 8),
                const HistoryTipsBanner(),
                
                // Spacing bawah agar tidak tertutup custom bottom navigation bar
                const SizedBox(height: 100), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}