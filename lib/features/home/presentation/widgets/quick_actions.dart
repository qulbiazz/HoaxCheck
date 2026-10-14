import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../../../panduan/presentation/pages/guide_detail_page.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback? onTapDetection;
  final VoidCallback? onTapRiwayat;
  final VoidCallback? onTapPanduan;

  const QuickActions({
    super.key,
    this.onTapDetection,
    this.onTapRiwayat,
    this.onTapPanduan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Aksi Cepat",
              style: TextStyle(
                color: AppColors.inverted,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Row(
        //   children: [
        //     Expanded(
        //       child: _buildActionCard(
        //         Icons.content_paste_rounded,
        //         "Tempel Teks",
        //         "Analisis cepat",
        //         AppColors.primary,
        //         onTap: onTapDetection,
        //       ),
        //     ),
        //     const SizedBox(width: 12),
        //     Expanded(
        //       child: _buildActionCard(
        //         Icons.edit_note_rounded,
        //         "Ketik Manual",
        //         "Tulis klaim",
        //         const Color(0xFF3B82F6),
        //         onTap: onTapDetection,
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                Icons.history,
                "Lihat Riwayat",
                "Jejak verifikasi",
                AppColors.neutral,
                onTap: onTapRiwayat,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                Icons.menu_book,
                "Panduan",
                "Pedoman Pers",
                AppColors.primary,
                onTap: onTapPanduan ?? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GuideDetailPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    IconData icon,
    String title,
    String subtitle,
    Color iconColor, {
    required VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.inverted,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.neutral, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}