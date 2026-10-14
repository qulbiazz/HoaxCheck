import '../../domain/entities/detection_entity.dart';
import '../../domain/repositories/detection_repository.dart';
import '../datasources/detection_remote_data_source.dart';

class DetectionRepositoryImpl implements DetectionRepository {
  final DetectionRemoteDataSource remoteDataSource;

  DetectionRepositoryImpl({DetectionRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? DetectionRemoteDataSourceImpl();

  @override
  Future<DetectionEntity> analyzeText(String text) async {
    return await remoteDataSource.analyzeText(text);
  }

  @override
  Future<void> saveDetectionToCloud(DetectionEntity entity) async {
    await remoteDataSource.saveDetection(entity);
  }
}
