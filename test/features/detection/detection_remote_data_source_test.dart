import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:hoaxcheck_app/core/config/ml_config.dart';
import 'package:hoaxcheck_app/features/detection/data/datasources/detection_remote_data_source.dart';

class MockHttpClient extends http.BaseClient {
  final Future<http.Response> Function(http.BaseRequest request) _handler;

  MockHttpClient(this._handler);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _handler(request);
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
    );
  }
}

void main() {
  group('DetectionRemoteDataSource ML Integration Tests', () {
    test('Mengintegrasikan respon HOAKS dari HoaxCheckML REST API secara presisi', () async {
      final mockClient = MockHttpClient((request) async {
        expect(request.url.toString(), MlConfig.mlApiUrl);
        expect(request.headers['Content-Type'], contains('application/json'));

        final responseJson = jsonEncode({
          "status": "success",
          "label": "HOAKS",
          "confidence": 99.1,
          "model_name": "Bernoulli Naive Bayes (NLP)",
          "execution_ms": 3.2,
          "patterns": [
            "Domain Tautan Tidak Resmi / Phishing",
            "Ajakan Teruskan Pesan (Forward Chain)"
          ],
          "evidence_hoax": ["bansos", "pendaftaran"],
          "evidence_valid": [],
          "recommendation_title": "Tindakan yang Disarankan:",
          "recommendation_text": "Hentikan penyebaran informasi ini ke ruang publik.",
          "score": 5.4,
          "total_vocab": 3006,
        });

        return http.Response(responseJson, 200, headers: {
          'content-type': 'application/json; charset=utf-8',
        });
      });

      final dataSource = DetectionRemoteDataSourceImpl(httpClient: mockClient);
      final result = await dataSource.analyzeText('Daftar bansos cair klik link bit.ly/bansos');

      expect(result.isHoax, isTrue);
      expect(result.status, 'Terindikasi Hoaks');
      expect(result.confidenceScore, closeTo(0.991, 0.001));
      expect(result.indicators, contains('Domain Tautan Tidak Resmi / Phishing'));
      expect(result.indicators.any((i) => i.contains('bansos')), isTrue);
      expect(result.explanation, contains('Hentikan penyebaran informasi ini'));
    });

    test('Mengintegrasikan respon VALID dari HoaxCheckML REST API secara presisi', () async {
      final mockClient = MockHttpClient((request) async {
        final responseJson = jsonEncode({
          "status": "success",
          "label": "VALID",
          "confidence": 99.8,
          "model_name": "Bernoulli Naive Bayes (NLP)",
          "execution_ms": 1.5,
          "patterns": ["Atribusi Sumber & Lembaga Formal"],
          "evidence_hoax": [],
          "evidence_valid": ["kementerian", "ekonomi"],
          "recommendation_title": "Informasi Dapat Diverifikasi:",
          "recommendation_text": "Teks memiliki struktur kalimat jurnalistik faktual.",
          "score": -12.4,
          "total_vocab": 3006,
        });

        return http.Response(responseJson, 200, headers: {
          'content-type': 'application/json; charset=utf-8',
        });
      });

      final dataSource = DetectionRemoteDataSourceImpl(httpClient: mockClient);
      final result = await dataSource.analyzeText('Kementerian Keuangan merilis rincian APBN');

      expect(result.isHoax, isFalse);
      expect(result.status, 'Informasi Valid');
      expect(result.confidenceScore, closeTo(0.998, 0.001));
      expect(result.indicators, contains('Atribusi Sumber & Lembaga Formal'));
      expect(result.indicators.any((i) => i.contains('kementerian')), isTrue);
      expect(result.explanation, contains('faktual'));
    });

    test('Graceful fallback ke mesin analisis offline cerdas jika endpoint ML down atau timeout', () async {
      final mockClient = MockHttpClient((request) async {
        throw http.ClientException('Connection refused to ML server');
      });

      final dataSource = DetectionRemoteDataSourceImpl(httpClient: mockClient);
      // Teks provokatif hoaks yang akan dideteksi oleh mesin analisis bawaan
      final result = await dataSource.analyzeText('Viralkan gawat bantuan dana pulsa gratis');

      expect(result.isHoax, isTrue);
      expect(result.status, 'Terindikasi Hoaks');
      expect(result.confidenceScore, greaterThan(0.8));
      expect(result.indicators.isNotEmpty, isTrue);
    });
  });
}
