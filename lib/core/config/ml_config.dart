/// Konfigurasi Machine Learning / Endpoint Model AI Deteksi Hoaks
class MlConfig {
  /// URL Endpoint API Model Machine Learning eksternal (FastAPI, Flask, HuggingFace, dsb).
  /// Jika dikosongkan (''), sistem secara cerdas menggunakan Intelligent NLP & Heuristic Engine bawaan.
  ///
  /// Contoh jika menggunakan server lokal (Android Emulator): 'http://10.0.2.2:8000/predict'
  /// Contoh jika di hosting publik: 'https://hoaxcheck-ml.up.railway.app/predict'
  static const String mlApiUrl = '';

  /// Nama Supabase Edge Function jika model dijalankan via Supabase Edge Function
  static const String edgeFunctionName = 'detect-hoax';

  /// Batas waktu (timeout) dalam detik sebelum beralih ke analisis cerdas offline
  static const int timeoutSeconds = 8;
}
