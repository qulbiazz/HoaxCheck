import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class AnalysisDetailPage extends StatelessWidget {
  final String analysisId;
  final String classification;
  final int confidence;
  final double analysisTimeSeconds;
  final bool isHoax;

  const AnalysisDetailPage({
    super.key,
    this.analysisId = "#HC-98234",
    this.classification = "Terindikasi Hoaks",
    this.confidence = 87,
    this.analysisTimeSeconds = 1.2,
    this.isHoax = true,
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
          "Detail Analisis",
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
              // Header Sub-bar: HASIL EKSTRAKSI NLP & ID
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "HASIL EKSTRAKSI NLP",
                        style: TextStyle(
                          color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? AppDarkColors.surface : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "ID $analysisId",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : const Color(0xFF334155),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // CARD 1: HERO PREDICTION CARD (Circular Confidence)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Badge Status
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isHoax ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                            size: 14,
                            color: statusColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            classification,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Circular Progress Dial
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: confidence / 100,
                              strokeWidth: 8,
                              backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFF1F5F9),
                              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "$confidence%",
                                style: TextStyle(
                                  color: isDark ? Colors.white : AppColors.inverted,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Confidence",
                                style: TextStyle(
                                  color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Title
                    Text(
                      "Tingkat Keyakinan Model IndoBERT",
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.inverted,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Klasifikasi probabilitas mengindikasikan struktur pesan manipulatif secara signifikan.",
                      style: TextStyle(
                        color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                        fontSize: 12,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),

                    // Pill Waktu Analisis
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 13,
                            color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Dianalisis dalam $analysisTimeSeconds detik",
                            style: TextStyle(
                              color: isDark ? AppDarkColors.textSecondary : const Color(0xFF475569),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // CARD 2: INDIKATOR YANG TERDETEKSI
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                            const Icon(Icons.fact_check_outlined, size: 18, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(
                              "Indikator yang Terdeteksi",
                              style: TextStyle(
                                color: isDark ? Colors.white : AppColors.inverted,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "3 Pola",
                            style: TextStyle(
                              color: Color(0xFF3730A3),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Pola 1: Bahasa Sensasional
                    _buildIndicatorItem(
                      isDark: isDark,
                      icon: Icons.campaign_outlined,
                      iconBg: const Color(0xFFFEE2E2),
                      iconColor: const Color(0xFFDC2626),
                      title: "Bahasa Sensasional & Provokatif",
                      badgeText: "Bobot Tinggi",
                      badgeColor: const Color(0xFFDC2626),
                      badgeBg: const Color(0xFFFEE2E2),
                      desc: "Teks menggunakan ungkapan hiperbolis yang cenderung memancing kepanikan emosional pembaca.",
                    ),
                    const SizedBox(height: 14),

                    // Pola 2: Ajakan Segera Membagikan
                    _buildIndicatorItem(
                      isDark: isDark,
                      icon: Icons.forward_to_inbox_outlined,
                      iconBg: const Color(0xFFE0E7FF),
                      iconColor: const Color(0xFF4F46E5),
                      title: "Ajakan Segera Membagikan",
                      badgeText: "Bobot Sedang",
                      badgeColor: const Color(0xFF2563EB),
                      badgeBg: const Color(0xFFDBEAFE),
                      desc: "Terdapat pola desakan untuk menyebarkan pesan ke grup lain sebelum diverifikasi ke sumber primer.",
                    ),
                    const SizedBox(height: 14),

                    // Pola 3: Tautan Tidak Terverifikasi
                    _buildIndicatorItem(
                      isDark: isDark,
                      icon: Icons.link_off_rounded,
                      iconBg: const Color(0xFFFFEDD5),
                      iconColor: const Color(0xFFEA580C),
                      title: "Tautan Tidak Terverifikasi",
                      badgeText: "Bobot Tinggi",
                      badgeColor: const Color(0xFFDC2626),
                      badgeBg: const Color(0xFFFEE2E2),
                      desc: "Mencantumkan tautan domain pihak ketiga yang tidak terafiliasi dengan lembaga resmi atau pers tersertifikasi.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // CARD 3: INFORMASI MODEL NLP
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                        const Icon(Icons.memory_outlined, size: 18, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          "Informasi Model NLP",
                          style: TextStyle(
                            color: isDark ? Colors.white : AppColors.inverted,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildInfoRow(isDark, "Arsitektur Model", "IndoBERT Text Classifier v2.4"),
                    const Divider(height: 18, thickness: 0.5),
                    _buildInfoRow(isDark, "Parameter Pelatihan", "Fine-tuned (Civic News Corpus)"),
                    const Divider(height: 18, thickness: 0.5),
                    _buildInfoRow(isDark, "Panjang Input Teks", "135 kata | 642 karakter"),
                    const Divider(height: 18, thickness: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status Inferensi",
                          style: TextStyle(
                            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDC2626),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "87% Probabilitas Anomali",
                              style: TextStyle(
                                color: Color(0xFFDC2626),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // CARD 4: APA ARTINYA HASIL INI? (Edukasi)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF064E3B).withValues(alpha: 0.3) : const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? const Color(0xFF059669) : const Color(0xFFA7F3D0),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.lightbulb_outline, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apa Artinya Hasil Ini?",
                            style: TextStyle(
                              color: isDark ? Colors.white : const Color(0xFF065F46),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Hasil ini menunjukkan bahwa model menemukan pola linguistik yang sangat mirip dengan kumpulan data informasi hoaks yang telah terverifikasi. Namun, hasil ini bukan bukti hukum bahwa informasi pasti salah. Gunakan sebagai sinyal waspada awal sebelum mempercayai atau membagikan konten.",
                            style: TextStyle(
                              color: isDark ? Colors.white70 : const Color(0xFF047857),
                              fontSize: 11,
                              height: 1.45,
                            ),
                          ),
                        ],
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
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.document_scanner_outlined, size: 18),
                  label: const Text(
                    "Periksa Teks Lain",
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
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.history,
                    size: 18,
                    color: isDark ? Colors.white70 : AppColors.inverted,
                  ),
                  label: Text(
                    "Kembali ke Riwayat",
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.inverted,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
                    side: BorderSide(
                      color: isDark ? Colors.transparent : const Color(0xFFCBD5E1),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // FOOTER DISCLAIMER
              Center(
                child: Text(
                  "Sistem deteksi berbasis pembelajaran mesin memiliki margin kesalahan statistik. Tetap lakukan konfirmasi manual melalui media massa terpercaya dan kanal pengecekan fakta independen (CekFakta/TurnBackHoax).",
                  style: TextStyle(
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8),
                    fontSize: 10,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicatorItem({
    required bool isDark,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBg,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: isDark ? Colors.white : AppColors.inverted,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badgeText,
                            style: TextStyle(
                              color: badgeColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      desc,
                      style: TextStyle(
                        color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(bool isDark, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.inverted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
