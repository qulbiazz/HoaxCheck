import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/notification/presentation/pages/notification_page.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  GlobalKey<NavigatorState>? navigatorKey;
  bool _isInitialized = false;
  RealtimeChannel? _realtimeChannel;

  // Cache waktu dan ID untuk mencegah duplikasi notifikasi lokal vs realtime
  final Set<String> _recentlyHandledTitles = {};

  Future<void> initialize({GlobalKey<NavigatorState>? navKey}) async {
    if (_isInitialized) return;
    if (navKey != null) {
      navigatorKey = navKey;
    }

    // Pengaturan inisialisasi Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Pengaturan inisialisasi iOS (Darwin)
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Minta izin notifikasi di Android 13+ dan iOS
    await requestPermissions();

    // Buat Notification Channels untuk Android
    await _createAndroidNotificationChannels();

    _isInitialized = true;
    debugPrint('✓ NotificationService berhasil diinisialisasi');
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notifikasi HP diketuk: payload = ${response.payload}');
    if (navigatorKey?.currentState != null) {
      navigatorKey!.currentState!.push(
        MaterialPageRoute(
          builder: (_) => const NotificationPage(),
        ),
      );
    }
  }

  /// Minta izin notifikasi (Android 13+ & iOS)
  Future<bool> requestPermissions() async {
    try {
      final androidImplementation = _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        final granted =
            await androidImplementation.requestNotificationsPermission();
        debugPrint('Izin notifikasi Android: $granted');
      }

      final iosImplementation = _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      if (iosImplementation != null) {
        final granted = await iosImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        debugPrint('Izin notifikasi iOS: $granted');
      }
      return true;
    } catch (e) {
      debugPrint('Error saat meminta izin notifikasi: $e');
      return false;
    }
  }

  /// Registrasi channel notifikasi Android dengan prioritas tinggi
  Future<void> _createAndroidNotificationChannels() async {
    final androidImplementation = _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation == null) return;

    // 1. Channel Deteksi AI / Machine Learning
    const AndroidNotificationChannel detectionChannel =
        AndroidNotificationChannel(
      'hoaxcheck_detection_channel',
      'Hasil Analisis Deteksi',
      description: 'Pemberitahuan hasil verifikasi teks berita/pesan otomatis',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    // 2. Channel Alert Hoaks Viral (Trending Hoax Alert)
    const AndroidNotificationChannel alertChannel =
        AndroidNotificationChannel(
      'hoaxcheck_alert_channel',
      'Peringatan Hoaks Viral',
      description: 'Peringatan cepat hoaks yang sedang ramai beredar',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    // 3. Channel Dukungan / Laporan Masalah
    const AndroidNotificationChannel supportChannel =
        AndroidNotificationChannel(
      'hoaxcheck_support_channel',
      'Tanggapan & Layanan Masalah',
      description: 'Pemberitahuan progres dan tanggapan laporan masalah',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    // 4. Channel Tips Literasi Digital
    const AndroidNotificationChannel tipsChannel =
        AndroidNotificationChannel(
      'hoaxcheck_tips_channel',
      'Tips Literasi Digital',
      description: 'Tips berkala menangkal disinformasi dan hoaks',
      importance: Importance.defaultImportance,
      playSound: true,
      enableVibration: true,
    );

    // 5. Channel Pembaruan Sistem & Model AI
    const AndroidNotificationChannel systemChannel =
        AndroidNotificationChannel(
      'hoaxcheck_system_channel',
      'Pembaruan Sistem & AI',
      description: 'Informasi pembaruan model NLP dan perbaikan fitur',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await androidImplementation.createNotificationChannel(detectionChannel);
    await androidImplementation.createNotificationChannel(alertChannel);
    await androidImplementation.createNotificationChannel(supportChannel);
    await androidImplementation.createNotificationChannel(tipsChannel);
    await androidImplementation.createNotificationChannel(systemChannel);
  }

  /// 1. Tampilkan notifikasi Status Bar HP untuk HASIL DETEKSI (Poin #2)
  Future<void> showDetectionNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    _recordRecentlyHandled(title);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'hoaxcheck_detection_channel',
      'Hasil Analisis Deteksi',
      channelDescription: 'Pemberitahuan hasil verifikasi teks berita/pesan',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformDetails,
      payload: payload ?? 'detection',
    );
    debugPrint('🔔 Notifikasi Deteksi ditampilkan di HP: $title');
  }

  /// 2. Tampilkan notifikasi Status Bar HP untuk ALERT HOAKS VIRAL (Poin #1)
  Future<void> showAlertNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    _recordRecentlyHandled(title);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'hoaxcheck_alert_channel',
      'Peringatan Hoaks Viral',
      channelDescription: 'Peringatan cepat hoaks yang sedang ramai beredar',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformDetails,
      payload: payload ?? 'alert',
    );
    debugPrint('🔔 Notifikasi Alert Hoaks Viral ditampilkan di HP: $title');
  }

  /// 3. Tampilkan notifikasi Status Bar HP untuk TANGGAPAN LAPORAN MASALAH (Poin #3)
  Future<void> showSupportNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    _recordRecentlyHandled(title);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'hoaxcheck_support_channel',
      'Tanggapan & Layanan Masalah',
      channelDescription: 'Pemberitahuan progres dan tanggapan laporan masalah',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformDetails,
      payload: payload ?? 'support',
    );
    debugPrint('🔔 Notifikasi Tanggapan Masalah ditampilkan di HP: $title');
  }

  /// 4. Tampilkan notifikasi Status Bar HP untuk TIPS LITERASI DIGITAL
  Future<void> showTipsNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    _recordRecentlyHandled(title);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'hoaxcheck_tips_channel',
      'Tips Literasi Digital',
      channelDescription: 'Tips berkala menangkal disinformasi dan hoaks',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformDetails,
      payload: payload ?? 'tips',
    );
    debugPrint('🔔 Notifikasi Tips Literasi ditampilkan di HP: $title');
  }

  /// 5. Tampilkan notifikasi Status Bar HP untuk PEMBARUAN SISTEM & AI
  Future<void> showSystemUpdateNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    _recordRecentlyHandled(title);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'hoaxcheck_system_channel',
      'Pembaruan Sistem & AI',
      channelDescription: 'Informasi pembaruan model NLP dan perbaikan fitur',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformDetails,
      payload: payload ?? 'system',
    );
    debugPrint('🔔 Notifikasi Pembaruan Sistem ditampilkan di HP: $title');
  }

  /// Catat judul untuk mencegah duplikasi sesaat
  void _recordRecentlyHandled(String title) {
    _recentlyHandledTitles.add(title);
    Timer(const Duration(seconds: 8), () {
      _recentlyHandledTitles.remove(title);
    });
  }

  /// Dengarkan pesan broadcast dan personal dari Supabase secara Realtime
  void startSupabaseRealtimeListener() {
    try {
      final client = Supabase.instance.client;
      _realtimeChannel?.unsubscribe();

      _realtimeChannel = client
          .channel('public:notifications:realtime')
          .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'notifications',
            callback: (payload) {
              final newRecord = payload.newRecord;
              if (newRecord.isEmpty) return;

              final currentUserId = client.auth.currentUser?.id;
              final recordUserId = newRecord['user_id']?.toString();

              // Hanya tangkap notifikasi broadcast (user_id null) atau personal untuk user ini
              final isForMe = recordUserId == null || recordUserId == currentUserId;
              if (!isForMe) return;

              final title = newRecord['title']?.toString() ?? 'Pemberitahuan Baru';
              final body = newRecord['description']?.toString() ?? '';
              final tagLabel = newRecord['tag_label']?.toString() ?? '';

              // Cek apakah baru saja dipicu oleh aksi lokal di perangkat ini
              if (_recentlyHandledTitles.contains(title)) {
                return;
              }

              // Pemicu berdasarkan kategori tag
              final lowerTag = tagLabel.toLowerCase();
              if (lowerTag.contains('waspada') || lowerTag.contains('hoaks')) {
                showAlertNotification(
                  title: title,
                  body: body,
                  payload: 'alert',
                );
              } else if (lowerTag.contains('tanggap') || lowerTag.contains('laporan')) {
                showSupportNotification(
                  title: title,
                  body: body,
                  payload: 'support',
                );
              } else if (lowerTag.contains('verifikasi') || lowerTag.contains('analisis')) {
                showDetectionNotification(
                  title: title,
                  body: body,
                  payload: 'detection',
                );
              } else if (lowerTag.contains('literasi') || lowerTag.contains('tips') || lowerTag.contains('edukasi')) {
                showTipsNotification(
                  title: title,
                  body: body,
                  payload: 'tips',
                );
              } else if (lowerTag.contains('update') || lowerTag.contains('sistem') || lowerTag.contains('model')) {
                showSystemUpdateNotification(
                  title: title,
                  body: body,
                  payload: 'system',
                );
              } else {
                showAlertNotification(
                  title: title,
                  body: body,
                  payload: 'general',
                );
              }
            },
          )
          .subscribe();

      debugPrint('✓ Realtime Supabase notifications listener aktif!');
    } catch (e) {
      debugPrint('Peringatan: Gagal mengaktifkan realtime Supabase: $e');
    }
  }

  void dispose() {
    _realtimeChannel?.unsubscribe();
  }
}
