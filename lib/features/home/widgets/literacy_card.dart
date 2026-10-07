import 'package:flutter/material.dart';

class LiteracyCard extends StatelessWidget {
  const LiteracyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x2600288E), width: 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment(-1, -1),
          end: Alignment(-1, 1),
          colors: [
            Color(0x1A00288E),
            Color(0xFFDCE9FF),
            Color(0x4D86F2E4),
          ],
        ),
      ),
      padding: const EdgeInsets.all(17),
      margin: const EdgeInsets.only(top: 16, bottom: 1),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 14,
                      height: 13,
                      child: Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/u2gykg9t_expires_30_days.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Text(
                      "LITERASI DIGITAL",
                      style: TextStyle(
                        color: Color(0xFF00288E),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  // PERBAIKAN: Hapus \n dan jadikan satu string panjang
                  child: Text(
                    "Jangan langsung percaya. Cek dulu sebelum menyebarkan.",
                    style: TextStyle(
                      color: Color(0xFF0B1C30),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  // PERBAIKAN: Hapus \n dan jadikan satu string panjang
                  child: Text(
                    "Verifikasi fakta sedini mungkin melindungi keluarga dan komunitas Anda dari bahaya disinformasi digital.",
                    style: TextStyle(
                      color: Color(0xFF444653),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: InkWell(
                    onTap: () {
                      print('Pressed');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF00288E),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Agar tombol tidak memanjang ke kanan
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 11,
                            height: 14,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/9sqvy42o_expires_30_days.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text(
                              "Mulai Pemeriksaan",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                            height: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/50kx30bo_expires_30_days.png",
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
          const SizedBox(width: 16), // Memberi sedikit jarak ke ikon pelindung
          SizedBox(
            width: 56,
            height: 56,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/fzuciwcd_expires_30_days.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}