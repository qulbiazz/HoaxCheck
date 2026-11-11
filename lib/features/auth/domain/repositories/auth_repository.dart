import 'dart:typed_data';
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
  Future<UserEntity> updateProfile({String? name, String? avatarUrl});
  Future<String> uploadAvatar({required Uint8List bytes, required String fileName});
  Future<void> sendPasswordResetEmail(String email);
}
