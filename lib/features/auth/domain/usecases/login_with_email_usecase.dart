import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;
  const LoginParams({required this.email, required this.password});
}

class LoginWithEmailUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;
  LoginWithEmailUseCase(this.repository);

  @override
  Future<UserEntity> call(LoginParams params) {
    return repository.loginWithEmail(params.email, params.password);
  }
}
