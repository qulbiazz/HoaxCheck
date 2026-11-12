import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/guide_model.dart';

abstract class GuideRemoteDataSource {
  Future<List<GuidePrincipleModel>> getPrinciples();
  Future<GuideContentModel> getGuideContent();
}

class GuideRemoteDataSourceImpl implements GuideRemoteDataSource {
  final SupabaseClient? _client;

  GuideRemoteDataSourceImpl({SupabaseClient? client}) : _client = client;

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
        return response
            .map((item) => GuidePrincipleModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint('Catatan GuideRemoteDataSource getPrinciples: $e. Menggunakan prinsip default.');
    }

    return GuidePrincipleModel.defaultPrinciples;
  }

  @override
  Future<GuideContentModel> getGuideContent() async {
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
        return GuideContentModel.fromJson(response);
      }
    } catch (e) {
      debugPrint('Catatan GuideRemoteDataSource getGuideContent: $e. Menggunakan konten default.');
    }

    return GuideContentModel.defaultContent;
  }
}
