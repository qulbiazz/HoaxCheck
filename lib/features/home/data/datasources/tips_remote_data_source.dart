import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tip_model.dart';

abstract class TipsRemoteDataSource {
  Future<List<TipModel>> getTips();
}

class TipsRemoteDataSourceImpl implements TipsRemoteDataSource {
  final SupabaseClient? _client;

  // In-memory cache tips edukasi literasi
  static List<TipModel>? _cachedTips;
  static DateTime? _cacheTimestamp;
  static const Duration _cacheDuration = Duration(minutes: 5);

  TipsRemoteDataSourceImpl({SupabaseClient? client}) : _client = client;

  static void invalidateCache() {
    _cachedTips = null;
    _cacheTimestamp = null;
  }

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
    if (_cachedTips != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheDuration) {
      return List<TipModel>.from(_cachedTips!);
    }

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
        final tips = response
            .map((item) => TipModel.fromJson(item))
            .toList();
        _cachedTips = List<TipModel>.from(tips);
        _cacheTimestamp = DateTime.now();
        return tips;
      }
    } catch (e) {
      debugPrint('Catatan TipsRemoteDataSource: $e. Menggunakan fallback tips bawaan.');
    }

    return TipModel.defaultTips;
  }
}
