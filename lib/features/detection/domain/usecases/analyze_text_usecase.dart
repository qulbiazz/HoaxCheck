import '../../../../core/usecases/usecase.dart';
import '../entities/detection_entity.dart';
import '../repositories/detection_repository.dart';

class AnalyzeTextUseCase implements UseCase<DetectionEntity, String> {
  final DetectionRepository repository;
  AnalyzeTextUseCase(this.repository);

  @override
  Future<DetectionEntity> call(String text) async {
    final result = await repository.analyzeText(text);
    // Simpan hasil deteksi ke cloud otomatis
    try {
      await repository.saveDetectionToCloud(result);
    } catch (_) {}
    return result;
  }
}
