import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Layanan penyimpanan lokal aplikasi menggunakan SharedPreferences
class StorageService {
  static const String _keyHasLoggedIn = 'has_logged_in';
  static const String _keyHasSeenOnboarding = 'has_seen_onboarding';

  /// Cek apakah pengguna sudah pernah login sebelumnya
  static Future<bool> hasLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyHasLoggedIn) ?? false;
    } catch (e) {
      debugPrint('StorageService.hasLoggedIn error: $e');
      return false;
    }
  }

  /// Tandai bahwa pengguna sudah pernah berhasil login
  static Future<void> setHasLoggedIn(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyHasLoggedIn, value);
    } catch (e) {
      debugPrint('StorageService.setHasLoggedIn error: $e');
    }
  }

  /// Cek apakah pengguna sudah pernah melihat/menyelesaikan onboarding
  static Future<bool> hasSeenOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyHasSeenOnboarding) ?? false;
    } catch (e) {
      debugPrint('StorageService.hasSeenOnboarding error: $e');
      return false;
    }
  }

  /// Tandai bahwa onboarding sudah diselesaikan / dilewati
  static Future<void> setHasSeenOnboarding(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyHasSeenOnboarding, value);
    } catch (e) {
      debugPrint('StorageService.setHasSeenOnboarding error: $e');
    }
  }

  /// Hapus status login (jika diperlukan untuk reset total)
  static Future<void> clearAuthPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyHasLoggedIn);
    } catch (e) {
      debugPrint('StorageService.clearAuthPreferences error: $e');
    }
  }
}
