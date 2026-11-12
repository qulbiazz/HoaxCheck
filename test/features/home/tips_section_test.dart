import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/home/data/datasources/tips_remote_data_source.dart';
import 'package:hoaxcheck_app/features/home/data/models/tip_model.dart';
import 'package:hoaxcheck_app/features/home/presentation/widgets/tips_section.dart';

class MockTipsDataSource implements TipsRemoteDataSource {
  final List<TipModel> tips;
  MockTipsDataSource({required this.tips});

  @override
  Future<List<TipModel>> getTips() async => tips;
}

void main() {
  group('TipsSection & TipModel Dynamic Tests', () {
    test('TipModel fromJson parses JSON fields correctly', () {
      final json = {
        'id': 'tip-100',
        'title': 'Uji Fakta Mandiri',
        'description': 'Lakukan pencarian Google Fact Check Tools sebelum percaya.',
        'tip_number': 'Tips #4',
        'icon_name': 'search',
        'icon_bg_hex': '#E0F2FE',
        'icon_color_hex': '#0284C7',
        'category': 'Digital Literacy',
        'order_index': 4,
      };

      final tip = TipModel.fromJson(json);
      expect(tip.id, 'tip-100');
      expect(tip.title, 'Uji Fakta Mandiri');
      expect(tip.tipNumber, 'Tips #4');
      expect(tip.iconName, 'search');
      expect(tip.orderIndex, 4);
      expect(tip.iconData, Icons.search_rounded);
    });

    testWidgets('TipsSection renders dynamic tips from mock data source', (tester) async {
      final mockDataSource = MockTipsDataSource(
        tips: const [
          TipModel(
            id: 'mock-1',
            title: 'Tips Khusus Dinamis',
            description: 'Penjelasan tips yang diambil dari database Supabase.',
            tipNumber: 'Tips #1',
            iconName: 'fact_check',
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: TipsSection(remoteDataSource: mockDataSource),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Tips Mengenali Hoaks'), findsOneWidget);
      expect(find.text('Tips Khusus Dinamis'), findsOneWidget);
      expect(find.text('Penjelasan tips yang diambil dari database Supabase.'), findsOneWidget);
    });

    testWidgets('TipsSection fallback ke defaultTips saat data source kosong', (tester) async {
      final mockDataSource = MockTipsDataSource(tips: []);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: TipsSection(remoteDataSource: mockDataSource),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Periksa sumber informasi'), findsOneWidget);
      expect(find.text('Waspada judul'), findsOneWidget);
    });
  });
}
