import 'package:flutter/material.dart';

class HowItWorksStepModel {
  final String number;
  final String iconName;
  final String title;
  final String description;

  const HowItWorksStepModel({
    required this.number,
    required this.iconName,
    required this.title,
    required this.description,
  });

  factory HowItWorksStepModel.fromJson(Map<String, dynamic> json) {
    return HowItWorksStepModel(
      number: json['number']?.toString() ?? '01',
      iconName: json['icon']?.toString() ?? 'edit_note',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  IconData get iconData {
    switch (iconName.toLowerCase()) {
      case 'psychology':
      case 'brain':
        return Icons.psychology_outlined;
      case 'fact_check':
      case 'check':
        return Icons.fact_check_outlined;
      case 'speed':
        return Icons.speed;
      case 'shield':
        return Icons.shield_outlined;
      case 'edit_note':
      default:
        return Icons.edit_note;
    }
  }
}

class AppInfoModel {
  final String appName;
  final String tagline;
  final String headerDescription;
  final String aboutDescription;
  final List<String> pills;
  final List<HowItWorksStepModel> steps;
  final String disclaimerText;
  final String appVersion;

  const AppInfoModel({
    required this.appName,
    required this.tagline,
    required this.headerDescription,
    required this.aboutDescription,
    required this.pills,
    required this.steps,
    required this.disclaimerText,
    required this.appVersion,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    final rawPills = json['pills'];
    List<String> parsedPills = [];
    if (rawPills is List) {
      parsedPills = rawPills.map((e) => e.toString()).toList();
    }

    final rawSteps = json['steps'];
    List<HowItWorksStepModel> parsedSteps = [];
    if (rawSteps is List) {
      for (final s in rawSteps) {
        if (s is Map<String, dynamic>) {
          parsedSteps.add(HowItWorksStepModel.fromJson(s));
        }
      }
    }

    return AppInfoModel(
      appName: json['app_name']?.toString() ?? defaultInfo.appName,
      tagline: json['tagline']?.toString() ?? defaultInfo.tagline,
      headerDescription: json['header_description']?.toString() ?? defaultInfo.headerDescription,
      aboutDescription: json['about_description']?.toString() ?? defaultInfo.aboutDescription,
      pills: parsedPills.isNotEmpty ? parsedPills : defaultInfo.pills,
      steps: parsedSteps.isNotEmpty ? parsedSteps : defaultInfo.steps,
      disclaimerText: json['disclaimer_text']?.toString() ?? defaultInfo.disclaimerText,
      appVersion: json['app_version']?.toString() ?? defaultInfo.appVersion,
    );
  }

  static AppInfoModel get defaultInfo => const AppInfoModel(
        appName: 'HoaxCheck',
        tagline: 'Bantu Kenali Informasi yang Meragukan',
        headerDescription:
            'HoaxCheck adalah aplikasi yang membantu pengguna mendapatkan indikasi awal terhadap informasi yang berpotensi hoaks melalui analisis teks berbasis Machine Learning.',
        aboutDescription:
            'Dirancang khusus untuk ekosistem literasi digital nusantara, HoaxCheck memadai struktur semantik, nuansa provokatif, serta konsistensi sintaksis pesan viral guna memetakan kemungkinan misinformasi secara objektif dalam hitungan detik.',
        pills: ['Deteksi < 3 Detik', 'Fokus Bahasa Indonesia'],
        steps: [
          HowItWorksStepModel(
            number: '01',
            iconName: 'edit_note',
            title: 'Masukkan Teks',
            description:
                'Masukkan atau tempel paragraf informasi, pesan berantai, atau kutipan berita yang ingin diperiksa.',
          ),
          HowItWorksStepModel(
            number: '02',
            iconName: 'psychology',
            title: 'Analisis Linguistik AI',
            description:
                'Sistem menganalisis pola kalimat, sentimen ekstrim, dan karakteristik disinformasi menggunakan model Machine Learning terlatih.',
          ),
          HowItWorksStepModel(
            number: '03',
            iconName: 'fact_check',
            title: 'Hasil & Skor Kepercayaan',
            description:
                'HoaxCheck menampilkan hasil indikasi beserta persentase confidence score secara lugas dan transparan.',
          ),
        ],
        disclaimerText:
            'HoaxCheck merupakan alat bantu deteksi awal dan bukan alat fact-checking resmi lembaga pers. Hasil yang diberikan merupakan prediksi probabilistik model kecerdasan buatan dan tetap perlu diverifikasi ulang melalui portal berita bersertifikat Dewan Pers.',
        appVersion: 'HoaxCheck v1.0.0',
      );
}
