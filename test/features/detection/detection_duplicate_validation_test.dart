import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/detection/domain/entities/detection_entity.dart';
import 'package:hoaxcheck_app/features/detection/domain/exceptions/already_detected_exception.dart';
import 'package:hoaxcheck_app/features/detection/domain/repositories/detection_repository.dart';
import 'package:hoaxcheck_app/features/detection/domain/usecases/analyze_text_usecase.dart';
import 'package:hoaxcheck_app/features/history/domain/entities/history_item.dart';

class MockDetectionRepository implements DetectionRepository {
  HistoryItem? mockDuplicate;
  bool isAnalyzeTextCalled = false;
  bool isSaveDetectionCalled = false;
  bool isDeleteHistoryCalled = false;
  String? lastDeletedId;

  @override
  Future<DetectionEntity> analyzeText(String text) async {
    isAnalyzeTextCalled = true;
    return DetectionEntity(
      text: text,
      confidenceScore: 0.90,
      status: 'Terindikasi Hoaks',
      isHoax: true,
      analysisId: '#HC-12345',
      analysisTimeSeconds: 1.0,
      indicators: const ['Pola Hoaks'],
      explanation: 'Penjelasan analisis',
    );
  }

  @override
  Future<void> saveDetectionToCloud(DetectionEntity entity) async {
    isSaveDetectionCalled = true;
  }

  @override
  Future<HistoryItem?> checkDuplicateDetection(String text) async {
    return mockDuplicate;
  }

  @override
  Future<void> deleteHistoryById(String id) async {
    isDeleteHistoryCalled = true;
    lastDeletedId = id;
    if (mockDuplicate?.id == id) {
      mockDuplicate = null;
    }
  }
}

void main() {
  group('Validasi Riwayat Deteksi 30 Hari', () {
    late MockDetectionRepository mockRepository;
    late AnalyzeTextUseCase analyzeTextUseCase;

    setUp(() {
      mockRepository = MockDetectionRepository();
      analyzeTextUseCase = AnalyzeTextUseCase(mockRepository);
    });

    test('Menolak deteksi jika berita sudah pernah dideteksi kurang dari 30 hari yang lalu dan belum dihapus', () async {
      final now = DateTime.now();
      mockRepository.mockDuplicate = HistoryItem(
        id: 'hist-1',
        title: 'Bansos cair via link bit.ly',
        snippet: 'Bansos cair via link bit.ly',
        isHoax: true,
        confidence: '95%',
        analysisType: 'Terindikasi Hoaks',
        source: 'Bernoulli Naive Bayes',
        time: '3 hari lalu',
        testedAt: now.subtract(const Duration(days: 3)), // 3 hari yang lalu (< 30 hari)
      );

      expect(
        () => analyzeTextUseCase('Bansos cair via link bit.ly'),
        throwsA(isA<AlreadyDetectedException>().having(
          (e) => e.daysAgo,
          'daysAgo',
          3,
        ).having(
          (e) => e.remainingDays,
          'remainingDays',
          27,
        )),
      );

      // Pastikan proses analisis ML dan penyimpanan tidak dijalankan
      expect(mockRepository.isAnalyzeTextCalled, isFalse);
      expect(mockRepository.isSaveDetectionCalled, isFalse);
    });

    test('Memperbolehkan deteksi jika berita sudah pernah dideteksi tetapi sudah lebih dari 30 hari yang lalu', () async {
      final now = DateTime.now();
      mockRepository.mockDuplicate = HistoryItem(
        id: 'hist-2',
        title: 'Bansos lama',
        snippet: 'Bansos lama',
        isHoax: true,
        confidence: '90%',
        analysisType: 'Terindikasi Hoaks',
        source: 'Bernoulli Naive Bayes',
        time: '35 hari lalu',
        testedAt: now.subtract(const Duration(days: 35)), // 35 hari yang lalu (> 30 hari)
      );

      final result = await analyzeTextUseCase('Bansos lama');

      expect(result, isNotNull);
      expect(mockRepository.isAnalyzeTextCalled, isTrue);
      expect(mockRepository.isSaveDetectionCalled, isTrue);
    });

    test('Memperbolehkan deteksi jika berita sudah dihapus dari riwayat (mockDuplicate == null)', () async {
      mockRepository.mockDuplicate = null; // Sudah dihapus pengguna

      final result = await analyzeTextUseCase('Berita yang sebelumnya dihapus');

      expect(result, isNotNull);
      expect(mockRepository.isAnalyzeTextCalled, isTrue);
      expect(mockRepository.isSaveDetectionCalled, isTrue);
    });

    test('Memperbolehkan deteksi ulang setelah pengguna menghapus item riwayat terkait', () async {
      final now = DateTime.now();
      mockRepository.mockDuplicate = HistoryItem(
        id: 'hist-del',
        title: 'Berita yang akan dihapus',
        snippet: 'Berita yang akan dihapus',
        isHoax: false,
        confidence: '88%',
        analysisType: 'Informasi Valid',
        source: 'Bernoulli Naive Bayes',
        time: '5 hari lalu',
        testedAt: now.subtract(const Duration(days: 5)),
      );

      // Deteksi pertama gagal karena belum dihapus
      expect(
        () => analyzeTextUseCase('Berita yang akan dihapus'),
        throwsA(isA<AlreadyDetectedException>()),
      );

      // Pengguna menghapus riwayat tersebut
      await mockRepository.deleteHistoryById('hist-del');
      expect(mockRepository.isDeleteHistoryCalled, isTrue);
      expect(mockRepository.mockDuplicate, isNull);

      // Deteksi kedua berhasil karena riwayat sudah terhapus
      final result = await analyzeTextUseCase('Berita yang akan dihapus');
      expect(result, isNotNull);
      expect(mockRepository.isAnalyzeTextCalled, isTrue);
    });
  });
}
