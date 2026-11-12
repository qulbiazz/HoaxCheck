import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  UserModel? getCurrentUser();
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> registerWithEmail(String email, String password, String name);
  Future<void> signInWithGoogle({String? redirectTo});
  Future<void> signOut();
  Stream<UserModel?> get authStateChanges;
  Future<UserModel> updateProfile({String? name, String? avatarUrl});
  Future<String> uploadAvatar({required Uint8List bytes, required String fileName});
  Future<void> sendPasswordResetEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient? _client;

  AuthRemoteDataSourceImpl({SupabaseClient? client}) : _client = client;

  SupabaseClient get supabaseClient {
    if (_client != null) return _client;
    return Supabase.instance.client;
  }

  SupabaseClient? get _safeSupabaseClient {
    if (_client != null) return _client;
    try {
      return Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }

  @override
  UserModel? getCurrentUser() {
    final client = _safeSupabaseClient;
    if (client == null) return null;
    final user = client.auth.currentUser;
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
    final client = _safeSupabaseClient;
    if (client == null) return const Stream.empty();
    return client.auth.onAuthStateChange.map((data) {
      final user = data.session?.user ?? client.auth.currentUser;
      if (user == null) return null;
      return UserModel.fromSupabase(user);
    });
  }

  @override
  Future<String> uploadAvatar({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw const AuthException('Pengguna belum login.');
    }

    final ext = fileName.contains('.') ? fileName.split('.').last.toLowerCase() : 'jpg';
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filePath = '${user.id}/avatar_$timestamp.$ext';

    await supabaseClient.storage.from('avatars').uploadBinary(
      filePath,
      bytes,
      fileOptions: FileOptions(
        contentType: 'image/$ext',
        upsert: true,
      ),
    );

    final publicUrl = supabaseClient.storage.from('avatars').getPublicUrl(filePath);
    return publicUrl;
  }

  @override
  Future<UserModel> updateProfile({String? name, String? avatarUrl}) async {
    final updateData = <String, dynamic>{};
    if (name != null && name.trim().isNotEmpty) {
      updateData['full_name'] = name.trim();
    }
    if (avatarUrl != null && avatarUrl.trim().isNotEmpty) {
      updateData['avatar_url'] = avatarUrl.trim();
    }

    final response = await supabaseClient.auth.updateUser(
      UserAttributes(data: updateData),
    );
    if (response.user == null) {
      throw const AuthException('Gagal memperbarui profil.');
    }

    // Sinkronisasi data ke tabel profiles jika tabel tersedia di Supabase
    try {
      await supabaseClient.from('profiles').upsert({
        'id': response.user!.id,
        if (name != null && name.trim().isNotEmpty) 'full_name': name.trim(),
        if (avatarUrl != null && avatarUrl.trim().isNotEmpty) 'avatar_url': avatarUrl.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (_) {}

    return UserModel.fromSupabase(response.user!);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await supabaseClient.auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.supabase.hoaxcheck://login-callback',
    );
  }
}
