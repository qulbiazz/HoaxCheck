import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/detection_entity.dart';

abstract class DetectionRemoteDataSource {
  Future<DetectionEntity> analyzeText(String text);
  Future<void> saveDetection(DetectionEntity entity);
}

class DetectionRemoteDataSourceImpl implements DetectionRemoteDataSource {
  final SupabaseClient supabaseClient;

  DetectionRemoteDataSourceImpl({SupabaseClient? client})
      : supabaseClient = client ?? Supabase.instance.client;

  @override
  Future<DetectionEntity> analyzeText(String text) async {
    // Simulasi analisis cerdas berbasis heuristik & NLP
    await Future.delayed(const Duration(milliseconds: 600));
    final lower = text.toLowerCase();
    final bool isHoax = lower.contains('hadiah') ||
        lower.contains('gratis') ||
        lower.contains('sebar') ||
        lower.contains('vaksin') ||
        lower.contains('batal') ||
        lower.contains('klik link');

    return DetectionEntity(
      text: text,
      confidenceScore: isHoax ? 0.88 : 0.92,
      status: isHoax ? 'Hoax / Misinformasi' : 'Informasi Valid',
      isHoax: isHoax,
    );
  }

  @override
  Future<void> saveDetection(DetectionEntity entity) async {
    final user = supabaseClient.auth.currentUser;
    await supabaseClient.from('user_histories').insert({
      if (user != null) 'user_id': user.id,
      'title': entity.text.length > 50
          ? '${entity.text.substring(0, 50)}...'
          : entity.text,
      'snippet': entity.text,
      'is_hoax': entity.isHoax,
      'confidence_str': '${(entity.confidenceScore * 100).toInt()}%',
      'classification': entity.status,
      'source': 'Analisis Mobile',
    });
  }
}
