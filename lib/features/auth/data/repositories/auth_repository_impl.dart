import 'dart:typed_data';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({AuthRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? AuthRemoteDataSourceImpl();

  @override
  UserEntity? getCurrentUserSync() {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<UserEntity> loginWithEmail(String email, String password) async {
    return await remoteDataSource.loginWithEmail(email, password);
  }

  @override
  Future<UserEntity> registerWithEmail(
    String email,
    String password,
    String name,
  ) async {
    return await remoteDataSource.registerWithEmail(email, password, name);
  }

  @override
  Future<void> signInWithGoogle({String? redirectTo}) async {
    await remoteDataSource.signInWithGoogle(redirectTo: redirectTo);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Stream<UserEntity?> get authStateChanges => remoteDataSource.authStateChanges;

  @override
  Future<UserEntity> updateProfile({String? name, String? avatarUrl}) async {
    return await remoteDataSource.updateProfile(name: name, avatarUrl: avatarUrl);
  }

  @override
  Future<String> uploadAvatar({
    required Uint8List bytes,
    required String fileName,
  }) async {
    return await remoteDataSource.uploadAvatar(bytes: bytes, fileName: fileName);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await remoteDataSource.sendPasswordResetEmail(email);
  }
}
