import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/profile/data/datasources/app_info_remote_data_source.dart';
import 'package:hoaxcheck_app/features/profile/data/models/app_info_model.dart';
import 'package:hoaxcheck_app/features/profile/presentation/pages/tentang_hoaxcheck_page.dart';

class MockAppInfoDataSource implements AppInfoRemoteDataSource {
  final AppInfoModel appInfo;
  MockAppInfoDataSource({required this.appInfo});

  @override
  Future<AppInfoModel> getAppInfo() async => appInfo;
}

void main() {
  group('TentangHoaxCheckPage & AppInfoModel Dynamic Tests', () {
    test('AppInfoModel fromJson parses JSON correctly', () {
      final json = {
        'app_name': 'HoaxCheck Pro',
        'tagline': 'Kenali Fakta Secepat Kilat',
        'header_description': 'Deskripsi header dinamis.',
        'about_description': 'Deskripsi tentang aplikasi dinamis.',
        'pills': ['Deteksi Kilat', 'AI Mutakhir'],
        'steps': [
          {
            'number': '01',
            'icon': 'edit_note',
            'title': 'Salin Pesan',
            'description': 'Langkah awal tempelkan pesan.',
          }
        ],
        'disclaimer_text': 'Pernyataan sangkalan dinamis.',
        'app_version': 'HoaxCheck v2.5.0',
      };

      final info = AppInfoModel.fromJson(json);
      expect(info.appName, 'HoaxCheck Pro');
      expect(info.tagline, 'Kenali Fakta Secepat Kilat');
      expect(info.pills, contains('Deteksi Kilat'));
      expect(info.steps.length, 1);
      expect(info.steps.first.title, 'Salin Pesan');
      expect(info.appVersion, 'HoaxCheck v2.5.0');
    });

    testWidgets('TentangHoaxCheckPage renders dynamic content from mock data source', (tester) async {
      final mockDataSource = MockAppInfoDataSource(
        appInfo: const AppInfoModel(
          appName: 'HoaxCheck PBL',
          tagline: 'Platform Literasi Digital Cerdas',
          headerDescription: 'Aplikasi pendeteksi hoaks berbasis NLP.',
          aboutDescription: 'Solusi cerdas bagi masyarakat untuk menyaring disinformasi.',
          pills: ['Akurasi Tinggi', 'Respons Cepat'],
          steps: [
            HowItWorksStepModel(
              number: '01',
              iconName: 'edit_note',
              title: 'Langkah Pertama Dinamis',
              description: 'Tempel pesan di kolom deteksi.',
            ),
          ],
          disclaimerText: 'Disclaimer pengujian PBL 2026.',
          appVersion: 'HoaxCheck v2.0.0-pbl',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: TentangHoaxCheckPage(remoteDataSource: mockDataSource),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('HoaxCheck PBL'), findsOneWidget);
      expect(find.text('Platform Literasi Digital Cerdas'), findsOneWidget);
      expect(find.text('Solusi cerdas bagi masyarakat untuk menyaring disinformasi.'), findsOneWidget);
      expect(find.text('Langkah Pertama Dinamis'), findsOneWidget);
      expect(find.text('HoaxCheck v2.0.0-pbl'), findsOneWidget);
    });
  });
}
