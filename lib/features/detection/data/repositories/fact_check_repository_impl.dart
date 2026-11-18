import '../../domain/entities/fact_check_entity.dart';
import '../../domain/repositories/fact_check_repository.dart';
import '../datasources/fact_check_remote_data_source.dart';

class FactCheckRepositoryImpl implements FactCheckRepository {
  final FactCheckRemoteDataSource remoteDataSource;

  FactCheckRepositoryImpl({FactCheckRemoteDataSource? dataSource})
      : remoteDataSource = dataSource ?? FactCheckRemoteDataSourceImpl();

  @override
  Future<List<FactCheckEntity>> searchClaims(
    String query, {
    String? languageCode,
  }) {
    return remoteDataSource.searchClaims(
      query,
      languageCode: languageCode,
    );
  }
}

