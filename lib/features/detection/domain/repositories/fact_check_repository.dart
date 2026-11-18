import '../entities/fact_check_entity.dart';

abstract class FactCheckRepository {
  /// Melakukan pencarian klaim faktual melalui Google Fact Check Tools API
  Future<List<FactCheckEntity>> searchClaims(
    String query, {
    String? languageCode,
  });
}

