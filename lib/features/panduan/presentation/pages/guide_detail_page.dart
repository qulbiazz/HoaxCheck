import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';
import '../widgets/guide_header.dart';
import '../widgets/guide_image_banner.dart';
import '../widgets/guide_quote_box.dart';
import '../widgets/guide_principle_card.dart';
import '../widgets/guide_checklist_box.dart';
import '../widgets/guide_action_footer.dart';

class GuideDetailPage extends StatelessWidget {
  const GuideDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
      appBar: const GuideHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GuideImageBanner(),
              const SizedBox(height: 20),
              const GuideQuoteBox(),
              const SizedBox(height: 20),
              
              GuidePrincipleCard(
                stepNumber: '1',
                title: 'Prinsip Uji Informasi (Check & Recheck)',
                description: 'Karya jurnalistik profesional dan komunikasi publik yang bertanggung jawab selalu memverifikasi kebenaran materi sebelum disebarkan kepada khalayak umum.',
                subPoints: [
                  {'icon': Icons.business_outlined, 'text': 'Menghubungi pihak berwenang atau narasumber primer secara langsung untuk konfirmasi keabsahan pernyataan.'},
                  {'icon': Icons.warning_amber_rounded, 'text': 'Menghindari sandifikasi repertoasi atau konten sensasional tanpa menyertakan bukti material yang teruji.'},
                  {'icon': Icons.insights_rounded, 'text': 'Melakukan penelusuran ulang terhadap klaim statistik dan konteks waktu saat dokumen tersebut.'},
                ],
              ),
              const SizedBox(height: 20),

              GuidePrincipleCard(
                stepNumber: '2',
                title: 'Ciri Berita Memenuhi Standar Verifikasi',
                description: 'Saat membaca laporan berita atau tilikan informasi, cermati elemen akuntabilitas redaksional berikut:',
                subPoints: [
                  {'icon': Icons.person_outline, 'text': 'Transparansi Penulis: Mencantumkan nama jurnalis dan susunan dewan redaksi yang jelas serta dapat ditelusuri rekam jejaknya.'},
                  {'icon': Icons.link, 'text': 'Rujukan Terbuka: Tautan atau lampiran dokumen resmi disertakan secara transparan dan bukan sekadar tangkapan layar terpotong.'},
                  {'icon': Icons.update, 'text': 'Pengakuan Keterbukaan: Secara jujur mengakui batasan informasi apabila konfirmasi dari pihak terkait masih berjalan.'},
                ],
              ),
              const SizedBox(height: 20),

              const GuideChecklistBox(),
              const SizedBox(height: 20),

              const GuideActionFooter(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}