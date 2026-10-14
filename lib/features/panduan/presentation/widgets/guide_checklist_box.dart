import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class GuideChecklistBox extends StatelessWidget {
  const GuideChecklistBox({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<String> checklistItems = [
      'Apakah berita mengutip sumber pertama yang kompeten dan kredibel?',
      'Apakah ada bukti dokumen, rekaman utuh, atau data penunjang resmi?',
      'Jika masih meragukan, uji teks klaim ke HoaxCheck sebelum disebarkan.',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppDarkColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.playlist_add_check_rounded, color: AppColors.primary, size: 22),
              SizedBox(width: 8),
              Text(
                'Hal yang Perlu Diperhatikan',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Gunakan daftar periksa klaim ini sebelum membagikan ulang kabar ke grup percakapan atau media sosial.',
            style: TextStyle(fontSize: 12, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B)),
          ),
          const SizedBox(height: 12),
          ...checklistItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_box_rounded,
                  size: 22,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: isDark ? AppDarkColors.textPrimary : const Color(0xFF334155),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}