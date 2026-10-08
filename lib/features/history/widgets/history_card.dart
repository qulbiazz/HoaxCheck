import 'package:flutter/material.dart';
import '../../../../app/theme.dart';

class HistoryCard extends StatelessWidget {
  final bool isHoax;
  final String confidence;
  final String time;
  final String text;
  final String analysisType;
  final String source;

  const HistoryCard({
    super.key,
    required this.isHoax,
    required this.confidence,
    required this.time,
    required this.text,
    required this.analysisType,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = isHoax ? AppColors.danger : AppColors.primary;
    final IconData statusIcon = isHoax ? Icons.warning_amber_rounded : Icons.check_circle;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(border: Border(left: BorderSide(color: statusColor, width: 4))),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Kartu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // KIRI: Badge Status & Keyakinan
                  // Dibungkus Expanded & Wrap agar badge aman di layar kecil dan tidak mendorong waktu
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: statusColor.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcon, color: statusColor, size: 12),
                              const SizedBox(width: 4),
                              Text(isHoax ? "Terindikasi Hoaks" : "Valid", style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(20)),
                          child: Text("$confidence Keyakinan", style: const TextStyle(color: Color(0xFF3730A3), fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // KANAN: Waktu
                  Text(time, style: const TextStyle(color: AppColors.neutral, fontSize: 10)),
                ],
              ),
              const SizedBox(height: 12),
              
              // Teks Konten
              Text(
                text, 
                style: const TextStyle(color: AppColors.inverted, fontSize: 13, height: 1.4, fontWeight: FontWeight.w500), 
                maxLines: 2, 
                overflow: TextOverflow.ellipsis
              ),
              const SizedBox(height: 12),
              
              // Footer Kartu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // KIRI: Analisis dan Sumber
                  // Dibungkus Expanded dan Flexible agar teks yang sangat panjang dipotong rapi (...)
                  Expanded(
                    child: Row(
                      children: [
                        Icon(isHoax ? Icons.troubleshoot : Icons.verified_user_outlined, size: 12, color: statusColor),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            analysisType, 
                            style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis, // Memotong teks panjang
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6), 
                          child: Text("•", style: TextStyle(color: AppColors.neutral, fontSize: 10))
                        ),
                        Flexible(
                          child: Text(
                            source, 
                            style: const TextStyle(color: AppColors.neutral, fontSize: 10),
                            overflow: TextOverflow.ellipsis, // Memotong teks panjang
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, size: 16, color: AppColors.neutral),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}