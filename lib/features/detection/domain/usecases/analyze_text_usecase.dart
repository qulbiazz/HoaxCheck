import '../../../../core/usecases/usecase.dart';
import '../entities/detection_entity.dart';
import '../exceptions/already_detected_exception.dart';
import '../repositories/detection_repository.dart';

class AnalyzeTextUseCase implements UseCase<DetectionEntity, String> {
  final DetectionRepository repository;
  AnalyzeTextUseCase(this.repository);

  @override
  Future<DetectionEntity> call(String text) async {
    // Validasi aturan 30 hari: jika berita sudah pernah dideteksi dan belum dihapus dari riwayat, tolak deteksi
    final duplicate = await repository.checkDuplicateDetection(text);
    if (duplicate != null) {
      final now = DateTime.now();
      final testedAt = duplicate.testedAt ?? now;
      final diffDays = now.difference(testedAt).inDays;
      if (diffDays < 30) {
        throw AlreadyDetectedException(
          existingItem: duplicate,
          daysAgo: diffDays,
          remainingDays: (30 - diffDays).clamp(1, 30),
        );
      }
    }

    final result = await repository.analyzeText(text);
    // Simpan hasil deteksi ke cloud otomatis
    try {
      await repository.saveDetectionToCloud(result);
    } catch (_) {}
    return result;
  }
}
