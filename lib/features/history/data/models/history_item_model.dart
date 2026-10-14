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
      time: map['tested_at'] != null ? 'Tersimpan di Supabase' : 'Baru saja',
    );
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
