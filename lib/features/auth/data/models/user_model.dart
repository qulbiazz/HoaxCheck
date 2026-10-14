import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user_entity.dart';

/// Model User yang mengonversi objek Supabase User ke UserEntity
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.name,
    super.avatarUrl,
  });

  factory UserModel.fromSupabase(User user) {
    final rawName = user.userMetadata?['full_name'] as String? ??
        user.userMetadata?['name'] as String?;
    final displayName = (rawName != null && rawName.trim().isNotEmpty)
        ? rawName.trim()
        : (user.email != null ? user.email!.split('@').first : 'Pengguna');

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: displayName,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }
}
