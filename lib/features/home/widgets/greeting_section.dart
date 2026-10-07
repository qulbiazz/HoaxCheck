import 'package:flutter/material.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // Memberikan sedikit jarak bawah dengan elemen selanjutnya
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PERBAIKAN 1: Gunakan Expanded agar kolom teks mengambil sisa ruang dengan dinamis
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Halo, Qulbi! 👋",
                  style: TextStyle(
                    color: Color(0xFF0B1C30),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4), // Jarak rapi antara judul dan subjudul
                // PERBAIKAN 2: Hapus SizedBox(width: 138) dan hilangkan \n manual pada string teks
                Text(
                  "Periksa kebenaran informasi sebelum membagikannya.",
                  style: TextStyle(
                    color: Color(0xFF444653),
                    fontSize: 14,
                    height: 1.4, // Spasi baris agar lebih nyaman dibaca jika teks memanjang
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12), // Jarak aman antara teks dan badge
          
          // BADGE AKUN TERVERIFIKASI
          InkWell(
            onTap: () {
              print('Badge Pressed');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                color: const Color(0xFF86F2E4),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Agar Row hanya mengambil ruang sebesar isinya
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    width: 14,
                    height: 14,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9999),
                      child: Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/dfgm8qc0_expires_30_days.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Text(
                    "Akun Terverifikasi",
                    style: TextStyle(
                      color: Color(0xFF006F66),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
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