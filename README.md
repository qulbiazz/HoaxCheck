# HoaxCheck

HoaxCheck adalah aplikasi Flutter untuk membantu pengguna mengenali potensi informasi hoaks dalam teks berbahasa Indonesia. Aplikasi ini memberikan indikasi awal melalui analisis teks berbasis Machine Learning, pencarian sumber pembanding melalui Google Fact Check Tools, serta riwayat pemeriksaan pengguna.

> HoaxCheck merupakan alat bantu deteksi awal dan bukan pengganti lembaga fact-checking resmi. Hasil analisis perlu diverifikasi kembali dari sumber primer yang kredibel.

## Fitur Utama

- **Deteksi teks hoaks** dengan endpoint Machine Learning eksternal atau fallback analisis offline.
- **Cek fakta dari klaim** melalui Google Fact Check Tools API beserta rujukan cadangan.
- **Riwayat pemeriksaan** untuk melihat, mencari, dan menghapus hasil analisis.
- **Autentikasi pengguna** dengan email/password dan Google Sign-In.
- **Notifikasi** untuk hasil deteksi dan pembaruan dari Supabase Realtime.
- **Laporan masalah**, halaman profil, kebijakan privasi, dan panduan literasi digital.
- **Mode terang dan gelap**.
- **Multi-platform** untuk Android, iOS, web, Windows, macOS, dan Linux.

## Teknologi

- Flutter dan Dart
- Supabase Authentication, Database, Storage, dan Realtime
- HTTP untuk integrasi API
- Google Fact Check Tools API
- Bernoulli Naive Bayes melalui API HoaxCheckML
- Shared Preferences
- Flutter Local Notifications
- Image Picker
- URL Launcher

## Struktur Proyek

```text
lib/
├── app/                  # Konfigurasi aplikasi, tema, dan navigasi utama
├── core/                 # Konstanta, konfigurasi, layanan, utilitas, dan widget umum
├── features/
│   ├── auth/             # Login, registrasi, dan lupa kata sandi
│   ├── detection/        # Deteksi teks dan pencarian cek fakta
│   ├── history/          # Riwayat pemeriksaan
│   ├── home/             # Beranda dan statistik pengguna
│   ├── notification/     # Pusat notifikasi
│   ├── onboarding/       # Alur pengenalan aplikasi
│   ├── panduan/          # Panduan literasi digital
│   ├── profile/          # Profil, kebijakan, dan laporan masalah
│   └── splash/           # Tampilan pembuka
├── navigation/           # Bottom navigation aplikasi
└── main.dart             # Titik masuk aplikasi
supabase/
└── schema.sql            # Skema tabel, RLS, storage, dan data awal
test/                     # Pengujian widget dan logika fitur
assets/images/            # Aset gambar aplikasi
```

## Persyaratan

- Flutter SDK
- Dart SDK sesuai batasan pada `pubspec.yaml`
- Android Studio atau perangkat/ emulator Android
- Supabase project untuk autentikasi, database, dan notifikasi
- Endpoint API HoaxCheckML untuk deteksi ML
- API key Google Fact Check Tools (opsional)

## Instalasi

1. Clone repository dan masuk ke direktori proyek:

```bash
git clone <URL_REPOSITORY_INI>
cd hoaxcheck_app
```

2. Instal dependency Flutter:

```bash
flutter pub get
```

3. Buat konfigurasi Supabase:

Salin template berikut:

```text
lib/core/config/supabase_config.example.dart
```

Menjadi:

```text
lib/core/config/supabase_config.dart
```

Kemudian isi `url` dan `anonKey` dari project Supabase Anda:

```dart
class SupabaseConfig {
  static const String url = 'https://project-id.supabase.co';
  static const String anonKey = 'SUPABASE_ANON_KEY';
}
```

Jangan menyimpan service role key atau credential rahasia lain di aplikasi Flutter.

4. Jalankan skema database:

Jalankan isi `supabase/schema.sql` pada Supabase Dashboard > SQL Editor.

Skema ini membuat tabel berikut beserta Row Level Security:

- `user_histories`
- `problem_reports`
- `notifications`
- `profiles`
- `app_policies`
- `literacy_tips`
- `guide_principles`
- `guide_contents`
- `app_info`

Skema juga membuat bucket storage `avatars` dan trigger sinkronisasi pengguna ke tabel `profiles`.

## Konfigurasi API Deteksi

URL default endpoint Machine Learning adalah:

```text
http://10.0.2.2:5000/api/predict
```

Nilai tersebut dapat diganti melalui variabel build `ML_API_URL`:

```bash
flutter run --dart-define=ML_API_URL=http://10.0.2.2:5000/api/predict
```

Contoh endpoint berdasarkan lingkungan:

- Android Emulator: `http://10.0.2.2:5000/api/predict`
- Perangkat fisik melalui ADB Reverse:

```bash
adb reverse tcp:5000 tcp:5000
```

Kemudian gunakan `http://127.0.0.1:5000/api/predict`.

- Perangkat fisik dalam jaringan Wi-Fi yang sama: `http://IP_LAPTOP:5000/api/predict`
- Server publik: `https://domain-api-anda/api/predict`

Permintaan API harus mengirim JSON:

```json
{
  "text": "Teks yang akan diperiksa",
  "model": "bernoulli"
}
```

Jika endpoint tidak tersedia atau melampaui batas waktu lima detik, aplikasi secara otomatis menggunakan analisis offline bawaan.

## Konfigurasi Google Fact Check Tools

Konfigurasi API key bersifat opsional:

```bash
flutter run --dart-define=GOOGLE_FACT_CHECK_API_KEY=YOUR_API_KEY
```

Tanpa API key atau jika API tidak dapat diakses, aplikasi menggunakan rujukan pencarian faktual cadangan yang tersedia secara lokal.

## Menjalankan Aplikasi

Android:

```bash
flutter run
```

Dengan konfigurasi API khusus:

```bash
flutter run \
  --dart-define=ML_API_URL=http://10.0.2.2:5000/api/predict \
  --dart-define=GOOGLE_FACT_CHECK_API_KEY=YOUR_API_KEY
```

Platform lain dapat dijalankan menggunakan:

```bash
flutter run -d windows
flutter run -d chrome
flutter run -d macos
flutter run -d linux
```

## Pengujian

Jalankan semua pengujian:

```bash
flutter test
```

Jalankan pengujian tertarget, misalnya untuk deteksi:

```bash
flutter test test/features/detection
```

Analisis kode statis:

```bash
flutter analyze
```

## Build

Android APK:

```bash
flutter build apk
```

Android App Bundle:

```bash
flutter build appbundle
```

Web:

```bash
flutter build web
```

Windows:

```bash
flutter build windows
```

## Catatan Penting

- Supabase bersifat opsional saat aplikasi dijalankan. Tanpa kredensial yang valid, fitur deteksi offline tetap dapat digunakan.
- Riwayat hanya dapat disimpan melalui Supabase dan akan mengikuti kebijakan RLS pada skema proyek.
- File `supabase_config.dart` berisi konfigurasi proyek dan sebaiknya tidak menyertakan kunci rahasia.
- Hasil Machine Learning adalah prediksi probabilistik, bukan keputusan faktual final.