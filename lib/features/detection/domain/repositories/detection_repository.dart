import '../entities/detection_entity.dart';

/// Kontrak Repository Deteksi (Domain Interface)
abstract class DetectionRepository {
  Future<DetectionEntity> analyzeText(String text);
  Future<void> saveDetectionToCloud(DetectionEntity entity);
}
