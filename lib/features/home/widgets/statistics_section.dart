import 'package:flutter/material.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Statistik Personal",
                    style: TextStyle(color: Color(0xFF0B1C30), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Akumulasi Bulan Ini",
                    style: TextStyle(color: Color(0xFF444653), fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  _buildStatCard(
                    title: "Total Periksa",
                    value: "24",
                    unit: "kali",
                    valueColor: const Color(0xFF00288E),
                    iconUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/6dj5ipgq_expires_30_days.png",
                    marginRight: 10,
                  ),
                  _buildStatCard(
                    title: "Hoaks",
                    value: "8",
                    unit: "kasus",
                    valueColor: const Color(0xFF700006),
                    iconUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/1tohvrlf_expires_30_days.png",
                    marginRight: 10,
                  ),
                  _buildStatCard(
                    title: "Valid",
                    value: "16",
                    unit: "fakta",
                    valueColor: const Color(0xFF006A61),
                    iconUrl: "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/6pfzvmmr_expires_30_days.png",
                    marginRight: 0,
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
              padding: const EdgeInsets.all(13),
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(9999), color: const Color(0xFF700006)),
                            margin: const EdgeInsets.only(right: 6),
                            width: 8, height: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: Text("33% Hoaks", style: TextStyle(color: Color(0xFF700006), fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                          const Text("(8)", style: TextStyle(color: Color(0xFF0B1C30), fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 7),
                            child: Text("67% Valid", style: TextStyle(color: Color(0xFF006A61), fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text("(16)", style: TextStyle(color: Color(0xFF0B1C30), fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(9999), color: const Color(0xFF006A61)),
                            width: 7, height: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(9999), color: const Color(0xFFE5EEFF)),
                    margin: const EdgeInsets.only(top: 6),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(9999), bottomLeft: Radius.circular(9999)),
                            color: Color(0xFF700006),
                          ),
                          width: 110, height: 8,
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(9999), bottomRight: Radius.circular(9999)),
                              color: Color(0xFF006A61),
                            ),
                            height: 8, width: double.infinity,
                          ),
                        ),
                      ],
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

  Widget _buildStatCard({required String title, required String value, required String unit, required Color valueColor, required String iconUrl, required double marginRight}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x4DC4C5D5), width: 1),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFFFFFFF),
        ),
        // PERBAIKAN 1: Padding internal dikurangi dari 13 menjadi 10 agar ruang lebih lega
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(right: marginRight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PERBAIKAN 2: Bungkus teks dengan Expanded agar teks turun baris saat ruang sempit
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Color(0xFF444653), fontSize: 11, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                ),
                const SizedBox(width: 4), // Ruang pemisah antara teks dan ikon
                SizedBox(
                  width: 12,
                  height: 12,
                  child: Image.network(iconUrl, fit: BoxFit.fill),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(value, style: TextStyle(color: valueColor, fontSize: 22, fontWeight: FontWeight.bold, height: 1.0)),
                  ),
                  Text(unit, style: const TextStyle(color: Color(0xFF444653), fontSize: 11, fontWeight: FontWeight.bold, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}