import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterParams {
  final String email;
  final String password;
  final String name;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.name,
  });
}

class RegisterWithEmailUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;
  RegisterWithEmailUseCase(this.repository);

  @override
  Future<UserEntity> call(RegisterParams params) {
    return repository.registerWithEmail(
      params.email,
      params.password,
      params.name,
    );
  }
}
