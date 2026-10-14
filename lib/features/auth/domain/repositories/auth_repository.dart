import '../entities/user_entity.dart';

/// Kontrak Repository Autentikasi (Domain Interface)
abstract class AuthRepository {
  UserEntity? getCurrentUserSync();
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> loginWithEmail(String email, String password);
  Future<UserEntity> registerWithEmail(String email, String password, String name);
  Future<void> signInWithGoogle({String? redirectTo});
  Future<void> signOut();
  Stream<UserEntity?> get authStateChanges;
}
