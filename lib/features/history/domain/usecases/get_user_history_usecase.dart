import '../../../../core/usecases/usecase.dart';
import '../entities/history_item.dart';
import '../repositories/history_repository.dart';

class GetUserHistoryUseCase implements UseCase<List<HistoryItem>, NoParams> {
  final HistoryRepository repository;
  GetUserHistoryUseCase(this.repository);

  @override
  Future<List<HistoryItem>> call(NoParams params, {bool forceRefresh = false}) {
    return repository.getUserHistories(forceRefresh: forceRefresh);
  }
}
