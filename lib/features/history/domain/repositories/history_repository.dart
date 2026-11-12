import '../entities/history_item.dart';

/// Kontrak Repository Riwayat (Domain Interface)
abstract class HistoryRepository {
  Future<List<HistoryItem>> getUserHistories();
  Future<void> saveHistory(HistoryItem item);
  Future<void> deleteHistory(String id);
  Future<void> clearAllHistory();
}
