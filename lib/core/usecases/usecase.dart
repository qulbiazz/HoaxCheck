/// Kontrak dasar UseCase dalam Clean Architecture
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {
  const NoParams();
}
