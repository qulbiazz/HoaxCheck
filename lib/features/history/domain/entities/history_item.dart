/// Entitas Riwayat Pemeriksaan Hoax dalam domain layer
class HistoryItem {
  final String? id;
  final String title;
  final String snippet;
  final bool isHoax;
  final String confidence;
  final String analysisType;
  final String source;
  final String time;

  const HistoryItem({
    this.id,
    required this.title,
    required this.snippet,
    required this.isHoax,
    required this.confidence,
    required this.analysisType,
    required this.source,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'isHoax': isHoax,
      'confidence': confidence,
      'time': time,
      'text': snippet.isNotEmpty ? snippet : title,
      'analysisType': analysisType,
      'source': source,
    };
  }
}
