import '../../domain/entities/history_item.dart';

/// Model History yang mengonversi response database Supabase ke HistoryItem
class HistoryItemModel extends HistoryItem {
  const HistoryItemModel({
    super.id,
    required super.title,
    required super.snippet,
    required super.isHoax,
    required super.confidence,
    required super.analysisType,
    required super.source,
    required super.time,
  });

  factory HistoryItemModel.fromMap(Map<String, dynamic> map) {
    return HistoryItemModel(
      id: map['id']?.toString(),
      title: map['title'] ?? map['snippet'] ?? '',
      snippet: map['snippet'] ?? map['title'] ?? '',
      isHoax: map['is_hoax'] ?? false,
      confidence: map['confidence_str'] ?? '80%',
      analysisType: map['classification'] ?? 'Analisis NLP',
      source: map['source'] ?? 'Cloud DB',
      time: _formatTime(map['tested_at']),
    );
  }

  static String _formatTime(dynamic testedAt) {
    if (testedAt == null) return 'Baru saja';
    try {
      final dt = DateTime.parse(testedAt.toString()).toLocal();
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inMinutes < 1) return 'Baru saja';
      if (diff.inMinutes < 60) return '${diff.inMinutes} mnt lalu';
      if (diff.inHours < 24 && dt.day == now.day) {
        final hour = dt.hour.toString().padLeft(2, '0');
        final minute = dt.minute.toString().padLeft(2, '0');
        return 'Hari ini, $hour:$minute WIB';
      }
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      final hour = dt.hour.toString().padLeft(2, '0');
      final minute = dt.minute.toString().padLeft(2, '0');
      return '$day/$month/${dt.year}, $hour:$minute WIB';
    } catch (_) {
      return 'Tersimpan di Cloud';
    }
  }

  Map<String, dynamic> toSupabaseMap(String? userId) {
    return {
      if (userId != null) 'user_id': userId,
      'title': title,
      'snippet': snippet,
      'is_hoax': isHoax,
      'confidence_str': confidence,
      'classification': analysisType,
      'source': source,
    };
  }
}
