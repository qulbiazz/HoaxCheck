import 'package:flutter/material.dart';

class TransparencyNote extends StatelessWidget {
  const TransparencyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x4DC4C5D5), width: 1),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFEFF4FF),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 16, bottom: 24), // Tambahan margin bawah agar tidak terlalu mepet dengan layar terbawah
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 16,
              height: 16, // Disesuaikan menjadi 16x16 agar ikon proporsional
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/98hekznr_expires_30_days.png",
                  fit: BoxFit.contain, // Menggunakan contain agar ikon tidak terpotong
                ),
              ),
            ),
            const Expanded(
              // PERBAIKAN: Hapus \n dan jadikan satu kalimat string utuh
              child: Text(
                "Catatan Transparansi: HoaxCheck menggunakan model NLP untuk memberikan indikasi awal, bukan alat verifikasi mutlak. Selalu konfirmasi pada kanal resmi terkait.",
                style: TextStyle(
                  color: Color(0xFF0B1C30), 
                  fontSize: 12, 
                  fontWeight: FontWeight.bold,
                  height: 1.4, // Ditambahkan agar spasi antar baris lebih rapi dan nyaman dibaca
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}