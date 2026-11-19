import '../../../history/domain/entities/history_item.dart';

/// Exception yang dilempar saat teks berita sudah pernah dideteksi
/// dan masih tersimpan di riwayat dalam batas 30 hari (belum dihapus).
class AlreadyDetectedException implements Exception {
  final HistoryItem existingItem;
  final int daysAgo;
  final int remainingDays;

  const AlreadyDetectedException({
    required this.existingItem,
    required this.daysAgo,
    required this.remainingDays,
  });

  @override
  String toString() {
    return 'Berita ini sudah pernah dideteksi ${daysAgo == 0 ? "hari ini" : "$daysAgo hari yang lalu"} dan masih tersimpan dalam riwayat.';
  }
}
