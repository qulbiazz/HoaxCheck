import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class GuideQuoteBox extends StatelessWidget {
  const GuideQuoteBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F4EA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFCEEAD6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.format_quote, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Berita yang kredibel dibangun atas fakta yang telah diuji ulang (cross-checked) ke sumber primer yang berwenang, bukan sekadar kutipan anonim atau rumor viral di lini masa.',
              style: TextStyle(
                color: Color(0xFF0D652D),
                fontSize: 13,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}