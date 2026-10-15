import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  UserModel? getCurrentUser();
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> registerWithEmail(String email, String password, String name);
  Future<void> signInWithGoogle({String? redirectTo});
  Future<void> signOut();
  Stream<UserModel?> get authStateChanges;
  Future<UserModel> updateProfile({required String name});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({SupabaseClient? client})
      : supabaseClient = client ?? Supabase.instance.client;

  @override
  UserModel? getCurrentUser() {
    final user = supabaseClient.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromSupabase(user);
  }

  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw const AuthException('Pengguna tidak ditemukan.');
    }
    return UserModel.fromSupabase(response.user!);
  }

  @override
  Future<UserModel> registerWithEmail(
    String email,
    String password,
    String name,
  ) async {
    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': name},
    );
    if (response.user == null) {
      throw const AuthException('Pendaftaran akun gagal.');
    }
    return UserModel.fromSupabase(response.user!);
  }

  @override
  Future<void> signInWithGoogle({String? redirectTo}) async {
    await supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: redirectTo,
    );
  }

  @override
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return supabaseClient.auth.onAuthStateChange.map((data) {
      final user = data.session?.user ?? supabaseClient.auth.currentUser;
      if (user == null) return null;
      return UserModel.fromSupabase(user);
    });
  }

  @override
  Future<UserModel> updateProfile({required String name}) async {
    final response = await supabaseClient.auth.updateUser(
      UserAttributes(data: {'full_name': name}),
    );
    if (response.user == null) {
      throw const AuthException('Gagal memperbarui profil.');
    }
    return UserModel.fromSupabase(response.user!);
  }
}
