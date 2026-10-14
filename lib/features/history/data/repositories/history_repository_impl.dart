import '../../domain/entities/history_item.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_data_source.dart';
import '../models/history_item_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl({HistoryRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? HistoryRemoteDataSourceImpl();

  @override
  Future<List<HistoryItem>> getUserHistories() async {
    return await remoteDataSource.getUserHistories();
  }

  @override
  Future<void> saveHistory(HistoryItem item) async {
    final model = HistoryItemModel(
      id: item.id,
      title: item.title,
      snippet: item.snippet,
      isHoax: item.isHoax,
      confidence: item.confidence,
      analysisType: item.analysisType,
      source: item.source,
      time: item.time,
    );
    await remoteDataSource.saveHistory(model);
  }

  @override
  Future<void> deleteHistory(String id) async {
    await remoteDataSource.deleteHistory(id);
  }
}
