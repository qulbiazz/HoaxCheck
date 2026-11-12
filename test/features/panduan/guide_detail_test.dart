import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/panduan/data/datasources/guide_remote_data_source.dart';
import 'package:hoaxcheck_app/features/panduan/data/models/guide_model.dart';
import 'package:hoaxcheck_app/features/panduan/presentation/pages/guide_detail_page.dart';

class MockGuideDataSource implements GuideRemoteDataSource {
  final List<GuidePrincipleModel> principles;
  final GuideContentModel content;

  MockGuideDataSource({required this.principles, required this.content});

  @override
  Future<List<GuidePrincipleModel>> getPrinciples() async => principles;

  @override
  Future<GuideContentModel> getGuideContent() async => content;
}

void main() {
  group('GuideDetailPage & GuideModel Dynamic Tests', () {
    test('GuidePrincipleModel and GuideContentModel parse JSON correctly', () {
      final principleJson = {
        'id': 'gp-1',
        'step_number': '1',
        'title': 'Prinsip Uji Berita',
        'description': 'Selalu cek ulang kebenaran data.',
        'sub_points': [
          {'icon': 'business', 'text': 'Hubungi instansi resmi terkait.'},
        ],
        'order_index': 1,
      };

      final principle = GuidePrincipleModel.fromJson(principleJson);
      expect(principle.id, 'gp-1');
      expect(principle.title, 'Prinsip Uji Berita');
      expect(principle.subPoints.length, 1);
      expect(principle.subPoints.first['text'], 'Hubungi instansi resmi terkait.');

      final contentJson = {
        'quote_text': 'Kutipan dinamis dari database.',
        'checklist_title': 'Daftar Periksa Khusus',
        'checklist_subtitle': 'Subjudul checklist dinamis.',
        'checklist_items': ['Poin cek 1', 'Poin cek 2'],
      };

      final content = GuideContentModel.fromJson(contentJson);
      expect(content.quoteText, 'Kutipan dinamis dari database.');
      expect(content.checklistItems.length, 2);
    });

    testWidgets('GuideDetailPage renders dynamic principles and content', (tester) async {
      final mockDataSource = MockGuideDataSource(
        principles: const [
          GuidePrincipleModel(
            id: 'gp-dyn-1',
            stepNumber: '1',
            title: 'Prinsip Dinamis Supabase',
            description: 'Deskripsi prinsip panduan yang diambil dari Supabase.',
            subPoints: [
              {'icon': Icons.business_outlined, 'text': 'Poin sub-prinsip dinamis.'},
            ],
          ),
        ],
        content: const GuideContentModel(
          quoteText: 'Kutipan inspiratif dari Supabase.',
          checklistTitle: 'Daftar Verifikasi Dinamis',
          checklistSubtitle: 'Cek daftar sebelum menyebarkan.',
          checklistItems: ['Langkah 1 dinamis', 'Langkah 2 dinamis'],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: GuideDetailPage(remoteDataSource: mockDataSource),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Prinsip Dinamis Supabase'), findsOneWidget);
      expect(find.text('Kutipan inspiratif dari Supabase.'), findsOneWidget);
      expect(find.text('Daftar Verifikasi Dinamis'), findsOneWidget);
      expect(find.text('Langkah 1 dinamis'), findsOneWidget);
    });
  });
}
