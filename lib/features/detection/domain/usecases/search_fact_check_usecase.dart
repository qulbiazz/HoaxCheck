import '../entities/fact_check_entity.dart';
import '../repositories/fact_check_repository.dart';

class SearchFactCheckUseCase {
  final FactCheckRepository repository;

  SearchFactCheckUseCase(this.repository);

  Future<List<FactCheckEntity>> call(
    String query, {
    String? languageCode,
  }) {
    return repository.searchClaims(
      query,
      languageCode: languageCode,
    );
  }
}

