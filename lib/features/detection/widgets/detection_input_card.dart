import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../pages/analysis_detail_page.dart';

class DetectionInputCard extends StatelessWidget {
  final TextEditingController controller;
  
  const DetectionInputCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text(
                    "Teks yang ingin\ndiperiksa",
                    style: TextStyle(
                      color: AppColors.inverted,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.info_outline, size: 14, color: AppColors.neutral),
                ],
              ),
              Row(
                children: [
                  _buildActionText(Icons.clear_all, "Bersihkan", AppColors.neutral),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  maxLines: 5,
                  style: const TextStyle(color: AppColors.inverted, fontSize: 14, height: 1.5),
                  decoration: const InputDecoration(
                    hintText: "Masukkan teks atau link di sini...",
                    hintStyle: TextStyle(color: AppColors.neutral, fontSize: 14),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    filled: false, 
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.language, size: 12, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text(
                            "Siap diuji model IndoBERT",
                            style: TextStyle(color: AppColors.inverted, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Text(
                        "0 / 2000 karakter",
                        style: TextStyle(color: AppColors.neutral, fontSize: 10),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AnalysisDetailPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF047857),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.auto_awesome, size: 18, color: AppColors.surface),
                  SizedBox(width: 8),
                  Text(
                    "Periksa Sekarang",
                    style: TextStyle(color: AppColors.surface, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionText(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        controller.clear(); 
      },
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}