import 'package:flutter/material.dart';

class GuidePrincipleModel {
  final String id;
  final String stepNumber;
  final String title;
  final String description;
  final List<Map<String, dynamic>> subPoints;
  final int orderIndex;

  const GuidePrincipleModel({
    required this.id,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.subPoints,
    this.orderIndex = 0,
  });

  factory GuidePrincipleModel.fromJson(Map<String, dynamic> json) {
    final rawSubPoints = json['sub_points'];
    final List<Map<String, dynamic>> parsedSubPoints = [];

    if (rawSubPoints is List) {
      for (final p in rawSubPoints) {
        if (p is Map) {
          final iconStr = p['icon']?.toString() ?? 'check';
          final text = p['text']?.toString() ?? '';
          parsedSubPoints.add({
            'icon': _resolveIcon(iconStr),
            'text': text,
          });
        }
      }
    }

    return GuidePrincipleModel(
      id: json['id']?.toString() ?? '',
      stepNumber: json['step_number']?.toString() ?? '1',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      subPoints: parsedSubPoints.isNotEmpty ? parsedSubPoints : _defaultSubPoints(json['step_number']?.toString() ?? '1'),
      orderIndex: json['order_index'] is int
          ? json['order_index'] as int
          : int.tryParse(json['order_index']?.toString() ?? '0') ?? 0,
    );
  }

  static IconData _resolveIcon(String iconStr) {
    switch (iconStr.toLowerCase()) {
      case 'business':
      case 'business_outlined':
        return Icons.business_outlined;
      case 'warning':
      case 'warning_amber':
      case 'warning_amber_rounded':
        return Icons.warning_amber_rounded;
      case 'insights':
      case 'insights_rounded':
      case 'analytics':
        return Icons.insights_rounded;
      case 'person':
      case 'person_outline':
      case 'user':
        return Icons.person_outline;
      case 'link':
      case 'url':
        return Icons.link;
      case 'update':
      case 'refresh':
      case 'history':
        return Icons.update;
      case 'fact_check':
        return Icons.fact_check_outlined;
      default:
        return Icons.verified_outlined;
    }
  }

  static List<Map<String, dynamic>> _defaultSubPoints(String step) {
    if (step == '2') {
      return [
        {
          'icon': Icons.person_outline,
          'text': 'Transparansi Penulis: Mencantumkan nama jurnalis dan susunan dewan redaksi yang jelas serta dapat ditelusuri rekam jejaknya.',
        },
        {
          'icon': Icons.link,
          'text': 'Rujukan Terbuka: Tautan atau lampiran dokumen resmi disertakan secara transparan dan bukan sekadar tangkapan layar terpotong.',
        },
        {
          'icon': Icons.update,
          'text': 'Pengakuan Keterbukaan: Secara jujur mengakui batasan informasi apabila konfirmasi dari pihak terkait masih berjalan.',
        },
      ];
    }
    return [
      {
        'icon': Icons.business_outlined,
        'text': 'Menghubungi pihak berwenang atau narasumber primer secara langsung untuk konfirmasi keabsahan pernyataan.',
      },
      {
        'icon': Icons.warning_amber_rounded,
        'text': 'Menghindari sensasionalisme atau konten provokatif tanpa menyertakan bukti material yang teruji.',
      },
      {
        'icon': Icons.insights_rounded,
        'text': 'Melakukan penelusuran ulang terhadap klaim statistik dan konteks waktu saat dokumen tersebut diterbitkan.',
      },
    ];
  }

  static List<GuidePrincipleModel> get defaultPrinciples => [
        GuidePrincipleModel(
          id: 'principle-1',
          stepNumber: '1',
          title: 'Prinsip Uji Informasi (Check & Recheck)',
          description:
              'Karya jurnalistik profesional dan komunikasi publik yang bertanggung jawab selalu memverifikasi kebenaran materi sebelum disebarkan kepada khalayak umum.',
          subPoints: _defaultSubPoints('1'),
          orderIndex: 1,
        ),
        GuidePrincipleModel(
          id: 'principle-2',
          stepNumber: '2',
          title: 'Ciri Berita Memenuhi Standar Verifikasi',
          description:
              'Saat membaca laporan berita atau tilikan informasi, cermati elemen akuntabilitas redaksional berikut:',
          subPoints: _defaultSubPoints('2'),
          orderIndex: 2,
        ),
      ];
}

class GuideContentModel {
  final String quoteText;
  final String checklistTitle;
  final String checklistSubtitle;
  final List<String> checklistItems;

  const GuideContentModel({
    required this.quoteText,
    required this.checklistTitle,
    required this.checklistSubtitle,
    required this.checklistItems,
  });

  factory GuideContentModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['checklist_items'];
    List<String> items = [];
    if (rawItems is List) {
      items = rawItems.map((e) => e.toString()).toList();
    }

    return GuideContentModel(
      quoteText: json['quote_text']?.toString() ?? defaultContent.quoteText,
      checklistTitle: json['checklist_title']?.toString() ?? defaultContent.checklistTitle,
      checklistSubtitle: json['checklist_subtitle']?.toString() ?? defaultContent.checklistSubtitle,
      checklistItems: items.isNotEmpty ? items : defaultContent.checklistItems,
    );
  }

  static GuideContentModel get defaultContent => const GuideContentModel(
        quoteText:
            'Berita yang kredibel dibangun atas fakta yang telah diuji ulang (cross-checked) ke sumber primer yang berwenang, bukan sekadar kutipan anonim atau rumor viral di lini masa.',
        checklistTitle: 'Hal yang Perlu Diperhatikan',
        checklistSubtitle:
            'Gunakan daftar periksa klaim ini sebelum membagikan ulang kabar ke grup percakapan atau media sosial.',
        checklistItems: [
          'Apakah berita mengutip sumber pertama yang kompeten dan kredibel?',
          'Apakah ada bukti dokumen, rekaman utuh, atau data penunjang resmi?',
          'Jika masih meragukan, uji teks klaim ke HoaxCheck sebelum disebarkan.',
        ],
      );
}
