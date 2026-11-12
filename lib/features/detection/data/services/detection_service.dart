import '../models/detection_result.dart';

class DetectionService {
  Future<DetectionResult> analyzeText(String text) async {
    // Simulasi delay API
    await Future.delayed(const Duration(seconds: 2));
    return DetectionResult(
      text: text,
      confidenceScore: 0.85,
      status: "Valid",
    );
  }
}