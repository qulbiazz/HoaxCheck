import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x4DC4C5D5), width: 1),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFFFFFFF),
      ),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Agar sejajar secara vertikal
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: const Color(0xFF059669),
            ),
            margin: const EdgeInsets.only(right: 8),
            width: 10,
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Text(
              "Sistem Deteksi\nOnline", // Ini dibiarkan karena memang judul yang pendek
              style: TextStyle(
                color: Color(0xFF0B1C30),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // PERBAIKAN: Gunakan Expanded & hapus \n manual
          const Expanded(
            child: Text(
              "Model NLP siap digunakan (v2.4) • API Aktif",
              style: TextStyle(
                color: Color(0xFF444653),
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}