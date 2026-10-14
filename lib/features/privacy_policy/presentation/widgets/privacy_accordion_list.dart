import 'package:flutter/material.dart';

class PrivacyAccordionList extends StatelessWidget {
  const PrivacyAccordionList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sections = [
      {
        'id': '1',
        'title': 'Pendahuluan',
        'icon': Icons.info_outline,
        'content': 'Kebijakan privasi ini menjelaskan secara komprehensif bagaimana HoaxCheck mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi Anda saat mengakses dan menggunakan aplikasi kami.'
      },
      {
        'id': '2',
        'title': 'Data yang Dikumpulkan',
        'icon': Icons.inventory_2_outlined,
        'isCustom': true,
      },
      {
        'id': '3',
        'title': 'Tujuan Penggunaan Data',
        'icon': Icons.track_changes_outlined,
        'content': 'Data yang dikumpulkan digunakan semata-mata untuk memverifikasi informasi, meningkatkan akurasi deteksi sistem AI, memproses pelaporan pengguna, dan mengoptimalkan fungsionalitas aplikasi.'
      },
      {
        'id': '4',
        'title': 'Penyimpanan Riwayat',
        'icon': Icons.history,
        'content': 'Riwayat pemeriksaan Anda disimpan secara sementara di peladen (server) kami menggunakan protokol enkripsi tingkat lanjut, dan akan dihapus secara otomatis dari sistem kami setelah 30 hari kalender.'
      },
      {
        'id': '5',
        'title': 'Pelatihan Model AI & NLP',
        'icon': Icons.psychology_outlined,
        'content': 'Kami menggunakan data teks pemeriksaan secara anonim tanpa atribut identitas untuk melatih dan menyempurnakan keandalan model pemrosesan bahasa alami (NLP). Tidak ada data pribadi yang dilibatkan dalam proses ini.'
      },
      {
        'id': '6',
        'title': 'Persetujuan Pengguna',
        'icon': Icons.how_to_reg,
        'content': 'Dengan menggunakan aplikasi HoaxCheck, Anda secara sadar dan tanpa paksaan menyetujui seluruh praktik pengumpulan serta penggunaan data yang telah diuraikan dalam dokumen kebijakan ini.'
      },
      {
        'id': '7',
        'title': 'Keamanan & Perlindungan',
        'icon': Icons.gpp_good_outlined,
        'content': 'Kami menerapkan standar keamanan industri terkini, termasuk teknologi enkripsi end-to-end (E2EE), guna melindungi data Anda dari akses, manipulasi, maupun pengungkapan yang tidak sah oleh pihak luar.'
      },
      {
        'id': '8',
        'title': 'Pembagian Data Pihak Ketiga',
        'icon': Icons.share_outlined,
        'content': 'HoaxCheck berkomitmen mutlak untuk tidak menjual, menyewakan, atau mendistribusikan data pribadi Anda kepada pihak ketiga mana pun untuk tujuan komersial, periklanan, maupun pemasaran.'
      },
      {
        'id': '9',
        'title': 'Hak & Kontrol Anda',
        'icon': Icons.tune,
        'content': 'Anda memiliki hak prerogatif untuk mengakses, meninjau, memperbarui, membatasi pemrosesan, hingga meminta penghapusan informasi pribadi Anda secara menyeluruh melalui menu pengaturan aplikasi.'
      },
      {
        'id': '10',
        'title': 'Prosedur Hapus Akun',
        'icon': Icons.person_remove_outlined,
        'content': 'Anda dapat menghapus akun Anda secara permanen beserta seluruh rekam jejak data terkait melalui menu profil. Seluruh entitas data Anda akan dimusnahkan dari sistem kami dalam kurun waktu maksimal 7 hari kerja.'
      },
      {
        'id': '11',
        'title': 'Perubahan Kebijakan',
        'icon': Icons.update,
        'content': 'Dokumen kebijakan privasi ini dapat mengalami pembaruan secara berkala menyesuaikan regulasi. Kami akan menyampaikan pemberitahuan resmi untuk setiap perubahan material melalui notifikasi langsung di dalam aplikasi.'
      },
      {
        'id': '12',
        'title': 'Kontak & Pengaduan',
        'icon': Icons.support_agent,
        'content': 'Jika Anda memiliki pertanyaan teknis, kekhawatiran terkait privasi, atau pengaduan mengenai kebijakan ini, silakan menghubungi tim Perlindungan Data kami melalui fasilitas pusat bantuan yang tersedia di aplikasi.'
      },
    ];

    return Column(
      children: sections.map((section) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: section['id'] == '2', // Data yang dikumpulkan otomatis terbuka
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(section['icon'], color: const Color(0xFF047857), size: 20),
              title: Text(
                "${section['id']}. ${section['title']}",
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              iconColor: const Color(0xFF64748B),
              collapsedIconColor: const Color(0xFF94A3B8),
              childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              children: [
                if (section['isCustom'] == true)
                  const _DataCollectionContent()
                else
                  Text(
                    section['content'],
                    style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.5),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _DataCollectionContent extends StatelessWidget {
  const _DataCollectionContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kami mengumpulkan data secara transparan yang terbagi dalam 3 pilar operasional:",
          style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 12),
        _buildDataBox(
            Icons.badge_outlined,
            "Data Akun",
            "Nama lengkap, alamat surel terverifikasi, serta kredensial autentikasi terenkripsi cryptographic salt untuk mengamankan hak akses Anda."),
        const SizedBox(height: 8),
        _buildDataBox(
            Icons.receipt_long_outlined,
            "Data Pemeriksaan",
            "Potongan teks berita atau klaim yang Anda masukkan untuk diuji, skor indeks keyakinan (confidence score), serta stempel waktu inferensi analitik."),
        const SizedBox(height: 8),
        _buildDataBox(
            Icons.feedback_outlined,
            "Data Laporan Koreksi",
            "Sanggahan atau laporan manual pengguna atas hasil verifikasi yang dinilai false-positive / false-negative bersama catatan rujukan fakta dari Anda."),
      ],
    );
  }

  Widget _buildDataBox(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF047857)),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            ],
          ),
          const SizedBox(height: 6),
          Text(desc, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.4)),
        ],
      ),
    );
  }
}