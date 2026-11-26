/// Konfigurasi Resmi Google Fact Check Tools API untuk HoaxCheck
/// 
/// Fitur ini terhubung ke layanan resmi Google Cloud: Fact Check Tools API.
/// Jika Anda memiliki API Key dari Google Cloud Console, masukkan di bawah ini
/// atau lewat parameter terminal saat run:
/// `flutter run --dart-define=GOOGLE_FACT_CHECK_API_KEY=AIzaSy...`
class GoogleFactCheckConfig {
  /// URL dasar endpoint Google Fact Check Tools API
  static const String apiBaseUrl =
      'https://factchecktools.googleapis.com/v1alpha1/claims:search';

  /// API Key Google Fact Check
  /// 
  /// Anda bisa menempelkan API Key Google Anda langsung di `defaultValue` berikut:
  static const String apiKey = String.fromEnvironment(
    'GOOGLE_FACT_CHECK_API_KEY',
    defaultValue: '', // Tempelkan API Key di sini (contoh: 'AIzaSy...') jika tidak menggunakan --dart-define
  );

  /// Bahasa default pemeriksaan klaim (Bahasa Indonesia: 'id')
  static const String defaultLanguageCode = 'id';

  /// Batas waktu pemanggilan API (detik)
  static const int timeoutSeconds = 5;

  /// Memeriksa apakah API Key Google telah terpasang dan valid
  static bool get hasApiKey =>
      apiKey.trim().isNotEmpty &&
      apiKey != 'MASUKKAN_GOOGLE_API_KEY_DI_SINI' &&
      apiKey != 'YOUR_KEY';

  /// Membangun Uri query pencarian yang aman dan terformat
  static Uri buildSearchUri(String query, {String? languageCode}) {
    final queryParams = <String, String>{
      'query': query,
      'languageCode': languageCode ?? defaultLanguageCode,
    };

    if (hasApiKey) {
      queryParams['key'] = apiKey.trim();
    }

    return Uri.parse(apiBaseUrl).replace(queryParameters: queryParams);
  }
}
