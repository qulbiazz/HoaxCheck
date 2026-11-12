class DetectionResult {
  final String text;
  final double confidenceScore;
  final String status; // "Valid", "Hoax", dll.

  DetectionResult({
    required this.text,
    required this.confidenceScore,
    required this.status,
  });
}