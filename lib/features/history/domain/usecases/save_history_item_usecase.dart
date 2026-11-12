import '../../../../core/usecases/usecase.dart';
import '../entities/history_item.dart';
import '../repositories/history_repository.dart';

class SaveHistoryItemUseCase implements UseCase<void, HistoryItem> {
  final HistoryRepository repository;
  SaveHistoryItemUseCase(this.repository);

  @override
  Future<void> call(HistoryItem item) {
    return repository.saveHistory(item);
  }
}
