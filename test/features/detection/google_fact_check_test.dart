import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:hoaxcheck_app/features/detection/data/datasources/fact_check_remote_data_source.dart';
import 'package:hoaxcheck_app/features/detection/data/models/fact_check_model.dart';
import 'package:hoaxcheck_app/features/detection/data/repositories/fact_check_repository_impl.dart';
import 'package:hoaxcheck_app/features/detection/domain/usecases/search_fact_check_usecase.dart';
import 'package:hoaxcheck_app/features/detection/presentation/pages/google_fact_check_page.dart';
import 'package:hoaxcheck_app/features/detection/presentation/widgets/google_fact_check_card.dart';

void main() {
  group('Google Fact Check Tests', () {
    test('FactCheckModel parses Google Fact Check Tools API json response correctly', () {
      final sampleJson = {
        'text': 'Beredar informasi vaksin booster gratis dibatalkan',
        'claimant': 'Facebook Post',
        'claimDate': '2024-02-01',
        'claimReview': [
          {
            'publisher': {
              'name': 'TurnBackHoax',
              'site': 'turnbackhoax.id',
            },
            'url': 'https://turnbackhoax.id/review/123',
            'title': '[SALAH] Vaksin Booster Berbayar',
            'reviewDate': '2024-02-02',
            'textualRating': 'Salah / Hoaks',
            'languageCode': 'id',
          }
        ]
      };

      final model = FactCheckModel.fromJson(sampleJson);
      expect(model.claimText, 'Beredar informasi vaksin booster gratis dibatalkan');
      expect(model.claimant, 'Facebook Post');
      expect(model.publisherName, 'TurnBackHoax');
      expect(model.publisherSite, 'turnbackhoax.id');
      expect(model.reviewTitle, '[SALAH] Vaksin Booster Berbayar');
      expect(model.reviewUrl, 'https://turnbackhoax.id/review/123');
      expect(model.rating, 'Salah / Hoaks');
      expect(model.isFalseClaim, isTrue);
    });

    test('FactCheckRemoteDataSource parses claims list from HTTP 200 response', () async {
      final mockClient = MockClient((request) async {
        final mockResponse = {
          'claims': [
            {
              'text': 'Klaim bansos tunai 2 juta',
              'claimant': 'WhatsApp',
              'claimReview': [
                {
                  'publisher': {'name': 'Kompas Cek Fakta', 'site': 'kompas.com'},
                  'url': 'https://kompas.com/cekfakta/1',
                  'title': 'Hoaks Bansos Tunai 2 Juta',
                  'textualRating': 'Hoaks',
                }
              ]
            }
          ]
        };
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final dataSource = FactCheckRemoteDataSourceImpl(client: mockClient);
      final results = await dataSource.searchClaims('bansos tunai');

      expect(results.length, 1);
      expect(results.first.publisherName, 'Kompas Cek Fakta');
      expect(results.first.rating, 'Hoaks');
    });

    test('FactCheckRemoteDataSource provides graceful verified fallback on network timeout/error', () async {
      final mockClient = MockClient((request) async {
        throw Exception('Network unreachable');
      });

      final dataSource = FactCheckRemoteDataSourceImpl(client: mockClient);
      final results = await dataSource.searchClaims('vaksin booster gratis');

      expect(results.isNotEmpty, isTrue);
      expect(results.first.publisherName, contains('TurnBackHoax'));
      expect(results.first.isFalseClaim, isTrue);
    });

    test('SearchFactCheckUseCase executes repository successfully', () async {
      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode({'claims': []}), 200);
      });
      final repo = FactCheckRepositoryImpl(
        dataSource: FactCheckRemoteDataSourceImpl(client: mockClient),
      );
      final useCase = SearchFactCheckUseCase(repo);

      final results = await useCase('bantuan subsidi pulsa');
      expect(results, isA<List>());
    });

    testWidgets('GoogleFactCheckCard renders and displays verified fact checks', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: GoogleFactCheckCard(
                queryText: 'pembagian kuota internet kemendikbud',
              ),
            ),
          ),
        ),
      );

      // Tunggu state asynchronous selesai memuat
      await tester.pumpAndSettle();

      expect(find.text('Google Fact Check'), findsOneWidget);
      expect(find.text('Tools API'), findsOneWidget);
    });

    testWidgets('GoogleFactCheckPage renders search bar and topic suggestions', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: GoogleFactCheckPage(),
        ),
      );

      expect(find.text('Google Fact Check'), findsOneWidget);
      expect(find.text('Cari klaim, isu, atau berita hoaks...'), findsOneWidget);
      expect(find.text('Vaksin Booster'), findsOneWidget);
      expect(find.text('Bansos Tunai'), findsOneWidget);
    });
  });
}

