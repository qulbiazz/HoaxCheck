import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import 'laporkan_shared.dart';

class LaporkanForm extends StatelessWidget {
  final String? selectedKategori;
  final ValueChanged<String?> onKategoriChanged;
  final TextEditingController deskripsiController;
  final TextEditingController emailController;

  const LaporkanForm({
    super.key,
    required this.selectedKategori,
    required this.onKategoriChanged,
    required this.deskripsiController,
    required this.emailController,
  });

  // 5 Kategori masalah
  static const List<String> kategoriList = [
    "Bug / Error Teknis",
    "Konten Tidak Akurat",
    "Masalah Privasi",
    "Saran Fitur Baru",
    "Lainnya",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==================== FIELD 1: JENIS MASALAH ====================
        const LaporkanFieldLabel(
          label: "Jenis Masalah",
          badge: "Wajib",
        ),
        const SizedBox(height: 8),
        LaporkanFieldContainer(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedKategori,
              isExpanded: true,
              hint: Text(
                "Pilih kategori masalah...",
                style: TextStyle(
                  color: isDark ? Colors.white54 : AppColors.neutral,
                  fontSize: 13,
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: isDark ? Colors.white54 : AppColors.neutral,
              ),
              dropdownColor: isDark ? AppDarkColors.surface : Colors.white,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.inverted,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              onChanged: onKategoriChanged,
              items: kategoriList.map((kategori) {
                return DropdownMenuItem<String>(
                  value: kategori,
                  child: Text(kategori),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            "Pilih klasifikasi agar tim pemeriksa kami dapat mengalokasikan laporan dengan tepat.",
            style: TextStyle(
              color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 22),

        // ==================== FIELD 2: DESKRIPSI MASALAH ====================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Deskripsi Masalah",
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.inverted,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Counter karakter (dinamis via ValueListenableBuilder)
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: deskripsiController,
              builder: (context, value, _) {
                final length = value.text.length;
                final isOverLimit = length > 500;
                return Text(
                  "$length / 500",
                  style: TextStyle(
                    color: isOverLimit
                        ? AppColors.danger
                        : (isDark
                            ? AppDarkColors.textSecondary
                            : AppColors.neutral),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        LaporkanFieldContainer(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: TextField(
            controller: deskripsiController,
            maxLines: 5,
            maxLength: 500,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.inverted,
              fontSize: 13,
              height: 1.5,
            ),
            decoration: InputDecoration(
              counterText: "", // sembunyikan counter bawaan TextField
              hintText:
                  "Ceritakan masalah atau kendala yang kamu alami secara detail...",
              hintStyle: TextStyle(
                color: isDark ? Colors.white38 : AppColors.neutral,
                fontSize: 13,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Info note
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.transparent : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 15,
                color: isDark
                    ? AppDarkColors.textSecondary
                    : const Color(0xFF64748B),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Sertakan klaim berita, tangkapan layar, atau kronologi bila relevan.",
                  style: TextStyle(
                    color: isDark
                        ? AppDarkColors.textSecondary
                        : const Color(0xFF64748B),
                    fontSize: 11.5,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),

        // ==================== FIELD 3: EMAIL ====================
        const LaporkanFieldLabel(
          label: "Email Kamu",
          badge: "Opsional",
        ),
        const SizedBox(height: 8),
        LaporkanFieldContainer(
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.inverted,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              icon: Icon(
                Icons.mail_outline,
                size: 18,
                color: isDark ? Colors.white38 : AppColors.neutral,
              ),
              hintText: "nama@email.com",
              hintStyle: TextStyle(
                color: isDark ? Colors.white38 : AppColors.neutral,
                fontSize: 13,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            "Masukkan email jika kamu ingin kami menghubungi kamu terkait tindak lanjut laporan.",
            style: TextStyle(
              color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}