import 'package:flutter/material.dart';

class RecentCheckSection extends StatelessWidget {
  const RecentCheckSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.only(bottom: 1),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pemeriksaan Terakhir",
                  style: TextStyle(color: Color(0xFF0B1C30), fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 6),
                      width: 14,
                      height: 14,
                      child: Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/9jier3mk_expires_30_days.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      "2 jam yang lalu",
                      style: TextStyle(color: Color(0xFF444653), fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0x4DC4C5D5), width: 1),
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFFFFFFF),
            ),
            margin: const EdgeInsets.only(top: 8),
            // ClipBehavior agar sudut garis merah tetap melengkung mengikuti Container
            clipBehavior: Clip.hardEdge, 
            width: double.infinity,
            child: IntrinsicHeight( // Agar tinggi garis merah otomatis mengikuti tinggi teks
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Memaksa garis merah mengisi tinggi penuh
                children: [
                  Container(
                    color: const Color(0xFF700006),
                    width: 6,
                    // Tidak perlu height statis lagi
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14), // Memberi ruang lega di dalam kartu
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0x33BA1A1A), width: 1),
                                  borderRadius: BorderRadius.circular(9999),
                                  color: const Color(0xB0FFDAD6),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 11),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      width: 12,
                                      height: 12,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(9999),
                                        child: Image.network(
                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/zgpzrlwr_expires_30_days.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Terindikasi Hoaks",
                                      style: TextStyle(color: Color(0xFF93000A), fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9999),
                                  color: const Color(0xFFDCE9FF),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Text("Confidence:", style: TextStyle(color: Color(0xFF444653), fontSize: 11, fontWeight: FontWeight.bold)),
                                    ),
                                    Text("87%", style: TextStyle(color: Color(0xFFBA1A1A), fontSize: 11, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 14, bottom: 14),
                            // PERBAIKAN: Hapus \n dan jadikan satu string panjang
                            child: Text(
                              "“Pesan pencairan bantuan pemerintah melalui link tautan bit.ly/bansos-kemensos-2025...”",
                              style: TextStyle(
                                color: Color(0xFF0B1C30), 
                                fontSize: 14,
                                height: 1.4, // Spasi baris agar lebih nyaman dibaca
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Sumber: Pesan WhatsApp Berantai", 
                                  style: TextStyle(color: Color(0xFF444653), fontSize: 11, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis, // Mencegah nama sumber panjang menabrak tombol
                                ),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text("Lihat Detail", style: TextStyle(color: Color(0xFF00288E), fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                    height: 9,
                                    child: Image.network(
                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/vu85k1pm_expires_30_days.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}