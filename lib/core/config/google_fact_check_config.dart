/// Konfigurasi Google Fact Check Tools API
class GoogleFactCheckConfig {
  /// URL dasar endpoint Google Fact Check Tools API
  static const String apiBaseUrl =
      'https://factchecktools.googleapis.com/v1alpha1/claims:search';

  /// API Key Google (opsional jika disuntikkan via dart-define)
  /// Contoh: `flutter run --dart-define=GOOGLE_FACT_CHECK_API_KEY=YOUR_KEY`
  static const String apiKey = String.fromEnvironment(
    'GOOGLE_FACT_CHECK_API_KEY',
    defaultValue: '',
  );

  /// Bahasa default pemeriksaan klaim (Bahasa Indonesia: 'id')
  static const String defaultLanguageCode = 'id';

  /// Timeout durasi pemanggilan API (detik)
  static const int timeoutSeconds = 6;

  /// Memeriksa apakah API Key Google telah terpasang
  static bool get hasApiKey => apiKey.trim().isNotEmpty;
}

