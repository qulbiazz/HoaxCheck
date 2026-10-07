import 'package:flutter/material.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        margin: const EdgeInsets.only(bottom: 2),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text("Info Hoaks Terkini", style: TextStyle(color: Color(0xFF0B1C30), fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9999), color: const Color(0xFF700006)),
                        width: 6, height: 6,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Text("Lihat Semua", style: TextStyle(color: Color(0xFF00288E), fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 9, height: 9,
                        child: Image.network("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/0v9zryaj_expires_30_days.png", fit: BoxFit.fill),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNewsCard(
                      category: "Penipuan",
                      time: "Hari ini",
                      // PERBAIKAN: Hapus \n manual pada teks, biarkan widget yang mengatur
                      title: "Klaim Subsidi Pulsa 250rb dari Kominfo di WhatsApp", 
                      source: "Mafindo / CekFakta",
                      sourceIcon: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/ya9w7ld1_expires_30_days.png",
                    ),
                    _buildNewsCard(
                      category: "Kesehatan",
                      time: "Kemarin",
                      // PERBAIKAN: Hapus \n manual pada teks
                      title: "Kabar Perubahan Aturan BPJS Kesehatan Otomatis Nonaktif", 
                      source: "Kemenkes RI",
                      sourceIcon: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/u8jdfura_expires_30_days.png",
                      marginRight: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard({required String category, required String time, required String title, required String source, required String sourceIcon, double marginRight = 12}) {
    return Container(
      width: 260, // PERBAIKAN: Set lebar spesifik untuk kartu agar semua seragam
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x4DC4C5D5), width: 1),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFFFFFF),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
      margin: EdgeInsets.only(right: marginRight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PERBAIKAN: Gunakan spaceBetween agar badge kategori dan teks waktu terdorong rapi ke kiri dan kanan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xFFFFDAD6)),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(category, style: const TextStyle(color: Color(0xFF410002), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Text(time, style: const TextStyle(color: Color(0xFF444653), fontSize: 11)),
            ],
          ),
          
          // PERBAIKAN: Gunakan maxLines dan overflow untuk teks yang kepanjangan
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              title,
              style: const TextStyle(color: Color(0xFF0B1C30), fontSize: 14, fontWeight: FontWeight.bold, height: 1.3),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // PERBAIKAN: Gunakan Expanded dan Row untuk menangani ikon sumber agar rapi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 6),
                      width: 14, height: 14,
                      child: Image.network(sourceIcon, fit: BoxFit.fill),
                    ),
                    Expanded(
                      child: Text(
                        source,
                        style: const TextStyle(color: Color(0xFF444653), fontSize: 11, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, // Menghindari overflow nama sumber
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 7, height: 13,
                child: Image.network("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/17tagezg_expires_30_days.png", fit: BoxFit.fill),
              ),
            ],
          ),
        ],
      ),
    );
  }
}