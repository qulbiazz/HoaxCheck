/// Template Konfigurasi Supabase
/// 
/// Salin file ini dan beri nama `supabase_config.dart` di folder yang sama:
/// lib/core/config/supabase_config.dart
///
/// Lalu masukkan Project URL dan Anon Key dari dashboard Supabase kelompok kamu.
class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'MASUKKAN_SUPABASE_URL_DI_SINI',
  );
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'MASUKKAN_ANON_KEY_DI_SINI',
  );
}
