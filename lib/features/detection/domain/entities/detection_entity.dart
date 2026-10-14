/// Entitas hasil deteksi hoax pada domain layer
class DetectionEntity {
  final String text;
  final double confidenceScore;
  final String status;
  final bool isHoax;

  const DetectionEntity({
    required this.text,
    required this.confidenceScore,
    required this.status,
    required this.isHoax,
  });
}
