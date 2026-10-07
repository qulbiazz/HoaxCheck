import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        margin: const EdgeInsets.only(bottom: 1),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                "Kategori yang Sering Diperiksa",
                style: TextStyle(color: Color(0xFF0B1C30), fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryChip(
                      title: "Kesehatan",
                      count: "42",
                      iconUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/cnyzmze0_expires_30_days.png",
                    ),
                    _buildCategoryChip(
                      title: "Politik",
                      count: "35",
                      iconUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/hzqyaje9_expires_30_days.png",
                    ),
                    _buildCategoryChip(
                      title: "Penipuan",
                      count: "38",
                      iconUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/5p3hy7ab_expires_30_days.png",
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

  Widget _buildCategoryChip({required String title, required String count, required String iconUrl, double marginRight = 12}) {
    return Padding(
      padding: EdgeInsets.only(right: marginRight),
      child: Material(
        color: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
          side: const BorderSide(color: Color(0x66C4C5D5), width: 1),
        ),
        // InkWell menambahkan efek hover dan ripple (ketika ditekan)
        child: InkWell(
          borderRadius: BorderRadius.circular(9999),
          hoverColor: const Color(0xFFEFF4FF), // Warna kebiruan ringan saat di-hover
          onTap: () {
            print('Kategori $title diklik');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  width: 14, 
                  height: 14,
                  // ClipRRect dihapus agar ikon tidak terpotong menjadi lingkaran
                  child: Image.network(iconUrl, fit: BoxFit.contain), 
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(title, style: const TextStyle(color: Color(0xFF0B1C30), fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(9999), color: const Color(0xFFE5EEFF)),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  child: Text(count, style: const TextStyle(color: Color(0xFF444653), fontSize: 11)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}