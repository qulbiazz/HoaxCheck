/// Konfigurasi Machine Learning / Endpoint Model AI Deteksi Hoaks
class MlConfig {
  /// URL Endpoint API Model Machine Learning dari repositori HoaxCheckML (Flask).
  ///
  /// Panduan URL sesuai lingkungan testing:
  /// - Android Emulator (Default): `http://10.0.2.2:5000/api/predict`
  /// - Perangkat Fisik via USB (ADB Reverse): `http://127.0.0.1:5000/api/predict`
  ///   (Jalankan di terminal laptop: `adb reverse tcp:5000 tcp:5000`)
  /// - Perangkat Fisik via Satu Wi-Fi (LAN): `http://[IP_LAPTOP]:5000/api/predict` (misal `http://192.168.1.15:5000/api/predict`)
  /// - Server Cloud Publik (Railway / Render): `https://[domain-anda]/api/predict`
  ///
  /// Bisa diatur saat run aplikasi melalui flag:
  /// `flutter run --dart-define=ML_API_URL=http://10.0.2.2:5000/api/predict`
  static String mlApiUrl = const String.fromEnvironment(
    'ML_API_URL',
    defaultValue: 'http://10.0.2.2:5000/api/predict',
  );

  /// Batas waktu (timeout) dalam detik sebelum beralih secara cerdas ke analisis offline bawaan
  static const int timeoutSeconds = 5;

  /// Memeriksa apakah endpoint ML sedang aktif terkonfigurasi
  static bool get isConfigured => mlApiUrl.trim().isNotEmpty;
}
