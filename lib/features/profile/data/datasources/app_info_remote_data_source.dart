import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/app_info_model.dart';

abstract class AppInfoRemoteDataSource {
  Future<AppInfoModel> getAppInfo();
}

class AppInfoRemoteDataSourceImpl implements AppInfoRemoteDataSource {
  final SupabaseClient? _client;

  AppInfoRemoteDataSourceImpl({SupabaseClient? client}) : _client = client;

  SupabaseClient? get _supabaseClient {
    if (_client != null) return _client;
    try {
      return Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AppInfoModel> getAppInfo() async {
    final client = _supabaseClient;
    if (client == null) {
      return AppInfoModel.defaultInfo;
    }

    try {
      final response = await client
          .from('app_info')
          .select()
          .limit(1)
          .maybeSingle();

      if (response != null) {
        return AppInfoModel.fromJson(response);
      }
    } catch (e) {
      debugPrint('Catatan AppInfoRemoteDataSource: $e. Menggunakan AppInfo default.');
    }

    return AppInfoModel.defaultInfo;
  }
}
