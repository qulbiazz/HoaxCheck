import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tip_model.dart';

abstract class TipsRemoteDataSource {
  Future<List<TipModel>> getTips();
}

class TipsRemoteDataSourceImpl implements TipsRemoteDataSource {
  final SupabaseClient? _client;

  TipsRemoteDataSourceImpl({SupabaseClient? client}) : _client = client;

  SupabaseClient? get _supabaseClient {
    if (_client != null) return _client;
    try {
      return Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<TipModel>> getTips() async {
    final client = _supabaseClient;
    if (client == null) {
      return TipModel.defaultTips;
    }

    try {
      final response = await client
          .from('literacy_tips')
          .select()
          .eq('is_active', true)
          .order('order_index', ascending: true);

      if (response.isNotEmpty) {
        return response
            .map((item) => TipModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint('Catatan TipsRemoteDataSource: $e. Menggunakan fallback tips bawaan.');
    }

    return TipModel.defaultTips;
  }
}
