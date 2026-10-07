import 'package:flutter/material.dart';

class TipsSection extends StatelessWidget {
  const TipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x3300288E), width: 1),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFEFF4FF),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 16, bottom: 1),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              width: 36,
              height: 38,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/myuv8ipn_expires_30_days.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Tips Deteksi Hoaks Hari Ini",
                    style: TextStyle(
                        color: Color(0xFF0B1C30),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6), // Sedikit menambah jarak atas
                    // PERBAIKAN: Hapus \n dan jadikan satu string panjang
                    child: Text(
                      "“Periksa sumber berita sebelum mempercayai judul yang provokatif. Perhatikan apakah media arus utama memberitakan hal serupa.”",
                      style: TextStyle(
                        color: Color(0xFF444653),
                        fontSize: 12,
                        height: 1.4, // Menambah jarak antar baris agar lebih nyaman dibaca
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}