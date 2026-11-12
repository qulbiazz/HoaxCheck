/// Entitas hasil deteksi hoax pada domain layer
class DetectionEntity {
  final String text;
  final double confidenceScore;
  final String status;
  final bool isHoax;
  final String analysisId;
  final double analysisTimeSeconds;
  final List<String> indicators;
  final String? explanation;

  const DetectionEntity({
    required this.text,
    required this.confidenceScore,
    required this.status,
    required this.isHoax,
    this.analysisId = "#HC-98234",
    this.analysisTimeSeconds = 1.2,
    this.indicators = const [],
    this.explanation,
  });
}
