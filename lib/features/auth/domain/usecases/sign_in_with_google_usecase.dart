import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase implements UseCase<void, String?> {
  final AuthRepository repository;
  SignInWithGoogleUseCase(this.repository);

  @override
  Future<void> call(String? redirectTo) {
    return repository.signInWithGoogle(redirectTo: redirectTo);
  }
}
