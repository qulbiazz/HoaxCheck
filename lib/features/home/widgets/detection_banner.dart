import 'dart:ui'; // Wajib ditambahkan untuk efek Blur
import 'package:flutter/material.dart';

class DetectionBanner extends StatelessWidget {
  const DetectionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment(-1, -1),
            end: Alignment(-1, 1),
            colors: [
              Color(0xFF00288E),
              Color(0xFF1E40AF),
              Color(0xFF1A389F),
            ],
          ),
        ),
        margin: const EdgeInsets.only(top: 16, bottom: 1),
        width: double.infinity,
        // Gunakan Clip.antiAlias agar efek blur tidak meluber ke luar kotak banner
        clipBehavior: Clip.antiAlias, 
        child: Stack(
          children: [
            // DEKORASI LINGKARAN BLUR
            Positioned(
              top: -10,
              right: -10,
              width: 144, // Dibuat kotak agar lingkarannya proporsional
              height: 144,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Mengatur tingkat blur
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x26FFFFFF), // Sedikit diterangkan agar blurnya terlihat
                  ),
                ),
              ),
            ),
            
            // GAMBAR SHIELD (TAMENG)
            Positioned(
              bottom: 0,
              right: 12,
              width: 120,
              height: 120,
              child: SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/a6xyd2d7_expires_30_days.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            // KONTEN TEKS & TOMBOL
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 32,
                          height: 32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/pvnwm6aw_expires_30_days.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Text(
                          "LAYANAN CEPAT",
                          style: TextStyle(color: Color(0xFFDDE1FF), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            "Deteksi Dini Hoaks",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Salin dan tempel berita atau pesan berantai\nuntuk memeriksa indikasi kebenaran.",
                          style: TextStyle(color: Color(0xFFA8B8FF), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('Pressed Periksa Sekarang');
                    },
                    child: IntrinsicWidth(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFFFFFF),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: const Text(
                                "Periksa Sekarang",
                                style: TextStyle(
                                  color: Color(0xFF00288E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                              height: 12,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/nf5kg77q_expires_30_days.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
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