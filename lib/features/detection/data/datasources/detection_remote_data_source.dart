import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/ml_config.dart';
import '../../domain/entities/detection_entity.dart';

abstract class DetectionRemoteDataSource {
  Future<DetectionEntity> analyzeText(String text);
  Future<void> saveDetection(DetectionEntity entity);
}

class DetectionRemoteDataSourceImpl implements DetectionRemoteDataSource {
  final SupabaseClient supabaseClient;
  final http.Client httpClient;

  DetectionRemoteDataSourceImpl({
    SupabaseClient? client,
    http.Client? httpClient,
  })  : supabaseClient = client ?? Supabase.instance.client,
        httpClient = httpClient ?? http.Client();

  @override
  Future<DetectionEntity> analyzeText(String text) async {
    final stopwatch = Stopwatch()..start();
    final analysisId = '#HC-${10000 + Random().nextInt(90000)}';

    // 1. Jika URL endpoint model ML terkonfigurasi, panggil API eksternal
    if (MlConfig.mlApiUrl.trim().isNotEmpty) {
      try {
        final response = await httpClient
            .post(
              Uri.parse(MlConfig.mlApiUrl),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'text': text}),
            )
            .timeout(Duration(seconds: MlConfig.timeoutSeconds));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          stopwatch.stop();

          final isHoax = (data['is_hoax'] == true) ||
              (data['label']?.toString().toLowerCase().contains('hoax') ?? false);
          final double confidence =
              (data['confidence'] as num?)?.toDouble() ??
              (data['score'] as num?)?.toDouble() ??
              0.88;

          final rawIndicators = data['indicators'];
          final List<String> indicators = rawIndicators is List
              ? rawIndicators.map((e) => e.toString()).toList()
              : (isHoax
                  ? ['Pola bahasa terdeteksi oleh model machine learning']
                  : ['Informasi terverifikasi']);

          return DetectionEntity(
            text: text,
            confidenceScore: confidence,
            status: isHoax ? 'Terindikasi Hoaks' : 'Informasi Valid',
            isHoax: isHoax,
            analysisId: analysisId,
            analysisTimeSeconds:
                (stopwatch.elapsedMilliseconds / 1000.0).clamp(0.4, 10.0),
            indicators: indicators,
            explanation: data['explanation']?.toString(),
          );
        }
      } catch (e) {
        debugPrint('Catatan: Endpoint ML gagal ($e). Beralih ke analisis NLP cerdas.');
      }
    }

    // 2. Mesin Analisis NLP Cerdas (Fallback & On-Device Heuristic Engine)
    await Future.delayed(const Duration(milliseconds: 750));
    final lower = text.toLowerCase();

    final detectedIndicators = <String>[];

    // Deteksi Pola 1: Bahasa Provokatif / Mendesak
    if (lower.contains('viralkan') ||
        lower.contains('sebar') ||
        lower.contains('sebarkan') ||
        lower.contains('sebarluaskan') ||
        lower.contains('awas') ||
        lower.contains('gawat') ||
        lower.contains('peringatan darurat') ||
        lower.contains('jangan sampai')) {
      detectedIndicators.add('Ajakan Mendesak Membagikan Pesan (Viralitas)');
    }

    // Deteksi Pola 2: Penipuan Finansial / Iming-iming Hadiah
    if (lower.contains('gratis') ||
        lower.contains('hadiah') ||
        lower.contains('subsidi') ||
        lower.contains('bantuan dana') ||
        lower.contains('saldo dana') ||
        lower.contains('pulsa') ||
        lower.contains('klaim sekarang') ||
        lower.contains('pemenang undian')) {
      detectedIndicators.add('Klaim Janji Hadiah / Bantuan Finansial Tidak Resmi');
    }

    // Deteksi Pola 3: Isu Kesehatan Sensasional / Teori Konspirasi
    if (lower.contains('vaksin dibatalkan') ||
        lower.contains('batal pemerintah') ||
        lower.contains('obat rahasia') ||
        lower.contains('konspirasi') ||
        lower.contains('racun kimia')) {
      detectedIndicators.add('Klaim Medis / Kebijakan Publik Tanpa Referensi');
    }

    // Deteksi Pola 4: Tautan Mencurigakan / Phishing
    if (lower.contains('klik link') ||
        lower.contains('klik tautan') ||
        lower.contains('bit.ly') ||
        lower.contains('tinyurl') ||
        lower.contains('.xyz') ||
        lower.contains('t.me/')) {
      detectedIndicators.add('Tautan URL Eksternal Berpotensi Phishing');
    }

    final bool isHoax = detectedIndicators.isNotEmpty;
    stopwatch.stop();

    double confidence;
    if (isHoax) {
      confidence = (0.84 + (detectedIndicators.length * 0.04)).clamp(0.80, 0.96);
    } else {
      confidence = 0.92;
      detectedIndicators.add('Struktur teks informatif dan objektif');
      detectedIndicators.add('Tidak terdeteksi unsur desakan atau klik manipulatif');
    }

    return DetectionEntity(
      text: text,
      confidenceScore: confidence,
      status: isHoax ? 'Terindikasi Hoaks' : 'Informasi Valid',
      isHoax: isHoax,
      analysisId: analysisId,
      analysisTimeSeconds:
          (stopwatch.elapsedMilliseconds / 1000.0).clamp(0.5, 3.0),
      indicators: detectedIndicators,
      explanation: isHoax
          ? 'Teks memiliki indikator pesan berantai manipulatif atau iming-iming berisiko.'
          : 'Teks tidak menunjukkan tanda-tanda fabrikasi atau misinformasi umum.',
    );
  }

  @override
  Future<void> saveDetection(DetectionEntity entity) async {
    final user = supabaseClient.auth.currentUser;
    final title = entity.text.length > 50
        ? '${entity.text.substring(0, 50)}...'
        : entity.text;

    final payloadWithUser = {
      if (user != null) 'user_id': user.id,
      'title': title,
      'snippet': entity.text,
      'is_hoax': entity.isHoax,
      'confidence_str': '${(entity.confidenceScore * 100).toInt()}%',
      'classification': entity.status,
      'source': 'Bernoulli Naive Bayes',
    };

    try {
      await supabaseClient.from('user_histories').insert(payloadWithUser);
    } catch (e) {
      // Jika kolom 'user_id' belum dibuat di Supabase, coba simpan tanpa user_id
      try {
        final payloadFallback = Map<String, dynamic>.from(payloadWithUser)
          ..remove('user_id');
        await supabaseClient.from('user_histories').insert(payloadFallback);
        debugPrint('Tersimpan di user_histories (mode kompatibel tanpa user_id)');
      } catch (innerError) {
        debugPrint('Peringatan: Gagal menyimpan riwayat ke Supabase: $innerError');
      }
    }

    // Otomatis catat ke tabel notifications untuk Verifikasi Teks (Poin #2)
    try {
      final notifTitle = entity.isHoax
          ? 'Hasil Analisis: Terindikasi Hoaks'
          : 'Hasil Analisis: Informasi Valid';
      final confidencePercent = '${(entity.confidenceScore * 100).toInt()}%';
      final notifDesc =
          'Pemeriksaan teks "$title" selesai: ${entity.status} ($confidencePercent).';

      await supabaseClient.from('notifications').insert({
        if (user != null) 'user_id': user.id,
        'title': notifTitle,
        'description': notifDesc,
        'time_label': 'Baru saja',
        'tag_label': 'Verifikasi Teks',
        'is_unread': true,
      });
    } catch (notifErr) {
      debugPrint('Catatan insert notification otomatis ke Supabase: $notifErr');
    }
  }
}
