import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/app.dart';
import 'core/config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase otomatis saat kredensial sudah kamu isi
  if (SupabaseConfig.url != 'MASUKKAN_SUPABASE_URL_DI_SINI' &&
      SupabaseConfig.anonKey != 'MASUKKAN_ANON_KEY_DI_SINI') {
    try {
      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
      );
      debugPrint('✓ Supabase berhasil terhubung!');
    } catch (e) {
      debugPrint('Gagal inisialisasi Supabase: $e');
    }
  }

  final tab = int.tryParse(Uri.base.queryParameters['tab'] ?? '0') ?? 0;
  final page = Uri.base.queryParameters['page'];
  runApp(HoaxCheckApp(initialIndex: tab, initialPage: page));
}