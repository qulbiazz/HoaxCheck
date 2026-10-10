import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme.dart';
import '../../detection/pages/analysis_detail_page.dart';

class HistoryDetailPage extends StatelessWidget {
  final String title;
  final String text;
  final String time;
  final String confidence;
  final bool isHoax;
  final String source;

  const HistoryDetailPage({
    super.key,
    this.title = "Pesan Berantai WhatsApp",
    this.text =
        "Beredar pesan berantai mengklaim vaksinasi booster gratis dibatalkan pemerintah dan diganti biaya mandiri mulai minggu depan dengan mendaftar di tautan tidak resmi bit.ly/booster-mandiri-update2026 sebelum kuota ditutup malam ini. Mohon sebarkan...",
    this.time = "08 Oktober 2026, 09:42 WIB",
    this.confidence = "87%",
    this.isHoax = true,
    this.source = "WhatsApp Forward",
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color statusColor = isHoax ? const Color(0xFFDC2626) : AppColors.primary;
    final Color statusBg = isHoax ? const Color(0xFFFEE2E2) : const Color(0xFFD1FAE5);

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : AppColors.inverted),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          "Detail Riwayat",
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
              // CARD 1: SUMMARY / STATS
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: statusColor, width: 4)),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isHoax ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                                    size: 13,
                                    color: statusColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    isHoax ? "Terindikasi Hoaks" : "Valid",
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 14,
                              color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              title,
                              style: TextStyle(
                                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Progress Bar & Confidence
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tingkat Keyakinan Model",
                              style: TextStyle(
                                color: isDark ? Colors.white : AppColors.inverted,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              confidence,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: 0.87,
                            minHeight: 7,
                            backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ambang Deteksi: 70%",
                              style: TextStyle(
                                color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                                fontSize: 11,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Risiko Tinggi",
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24, thickness: 0.6),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 13,
                              color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Diperiksa: $time",
                              style: TextStyle(
                                color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // CARD 2: TEKS YANG DIPERIKSA
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.description_outlined, size: 16, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(
                              "Teks yang Diperiksa",
                              style: TextStyle(
                                color: isDark ? Colors.white : AppColors.inverted,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Teks berhasil disalin ke clipboard!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy,
                                  size: 12,
                                  color: isDark ? Colors.white70 : const Color(0xFF334155),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Salin Teks",
                                  style: TextStyle(
                                    color: isDark ? Colors.white70 : const Color(0xFF334155),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: isDark ? Colors.white70 : const Color(0xFF334155),
                          fontSize: 12,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "49 kata (312 karakter)",
                          style: TextStyle(
                            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          "Teks Lengkap",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // CARD 3: RINGKASAN HASIL & LINK KE DETAIL ANALISIS
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shield_outlined, size: 16, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          "Ringkasan Hasil",
                          style: TextStyle(
                            color: isDark ? Colors.white : AppColors.inverted,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Model mendeteksi pola linguistik sensasional dan ajakan mendesak yang mengindikasikan teks ini berpotensi mengandung informasi hoaks.",
                      style: TextStyle(
                        color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Badges
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "⚠️ Ajakan Panik",
                                style: TextStyle(
                                  color: Color(0xFFDC2626),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "\"Mohon sebarkan...\"",
                                style: TextStyle(
                                  color: Color(0xFF991B1B),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "🔗 Tautan Anomali",
                                style: TextStyle(
                                  color: Color(0xFFDC2626),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "bit.ly/booster-tek.in",
                                style: TextStyle(
                                  color: Color(0xFF991B1B),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // BUTTON: LIHAT RINCIAN ANALISIS MODEL NLP
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AnalysisDetailPage(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF312E81).withValues(alpha: 0.3) : const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark ? const Color(0xFF4338CA) : const Color(0xFFC7D2FE),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.manage_search, size: 18, color: Color(0xFF4F46E5)),
                                const SizedBox(width: 8),
                                Text(
                                  "Lihat Rincian Analisis Model NLP",
                                  style: TextStyle(
                                    color: isDark ? const Color(0xFFA5B4FC) : const Color(0xFF3730A3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: isDark ? const Color(0xFFA5B4FC) : const Color(0xFF4F46E5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ACTION BUTTONS
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Tautan hasil pemeriksaan siap dibagikan!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.share_outlined, size: 18),
                  label: const Text(
                    "Bagikan Hasil",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF047857),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Item dihapus dari riwayat."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.delete_outline, size: 18, color: Color(0xFFDC2626)),
                  label: const Text(
                    "Hapus dari Riwayat",
                    style: TextStyle(
                      color: Color(0xFFDC2626),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isDark ? const Color(0xFF7F1D1D).withValues(alpha: 0.15) : const Color(0xFFFEF2F2),
                    side: const BorderSide(color: Color(0xFFFECACA)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // EDUKASI CALLOUT
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Catatan Edukasi: HoaxCheck merupakan alat bantu deteksi awal dan bukan pengganti verifikasi jurnalisme fakta. Selalu verifikasi kabar melalui kanal resmi lembaga terkait.",
                        style: TextStyle(
                          color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
