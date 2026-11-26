import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/guide_model.dart';

abstract class GuideRemoteDataSource {
  Future<List<GuidePrincipleModel>> getPrinciples();
  Future<GuideContentModel> getGuideContent();
}

class GuideRemoteDataSourceImpl implements GuideRemoteDataSource {
  final SupabaseClient? _client;

  // In-memory cache untuk panduan
  static List<GuidePrincipleModel>? _cachedPrinciples;
  static GuideContentModel? _cachedContent;
  static DateTime? _cacheTimestamp;
  static const Duration _cacheDuration = Duration(minutes: 10);

  GuideRemoteDataSourceImpl({SupabaseClient? client}) : _client = client;

  static void invalidateCache() {
    _cachedPrinciples = null;
    _cachedContent = null;
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
  Future<List<GuidePrincipleModel>> getPrinciples() async {
    if (_cachedPrinciples != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheDuration) {
      return List<GuidePrincipleModel>.from(_cachedPrinciples!);
    }

    final client = _supabaseClient;
    if (client == null) {
      return GuidePrincipleModel.defaultPrinciples;
    }

    try {
      final response = await client
          .from('guide_principles')
          .select()
          .order('order_index', ascending: true);

      if (response.isNotEmpty) {
        final principles = response
            .map((item) => GuidePrincipleModel.fromJson(item))
            .toList();
        _cachedPrinciples = List<GuidePrincipleModel>.from(principles);
        _cacheTimestamp = DateTime.now();
        return principles;
      }
    } catch (e) {
      debugPrint('Catatan GuideRemoteDataSource getPrinciples: $e. Menggunakan prinsip default.');
    }

    return GuidePrincipleModel.defaultPrinciples;
  }

  @override
  Future<GuideContentModel> getGuideContent() async {
    if (_cachedContent != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheDuration) {
      return _cachedContent!;
    }

    final client = _supabaseClient;
    if (client == null) {
      return GuideContentModel.defaultContent;
    }

    try {
      final response = await client
          .from('guide_contents')
          .select()
          .limit(1)
          .maybeSingle();

      if (response != null) {
        final content = GuideContentModel.fromJson(response);
        _cachedContent = content;
        _cacheTimestamp = DateTime.now();
        return content;
      }
    } catch (e) {
      debugPrint('Catatan GuideRemoteDataSource getGuideContent: $e. Menggunakan konten default.');
    }

    return GuideContentModel.defaultContent;
  }
}
