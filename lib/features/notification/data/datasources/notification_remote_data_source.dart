import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({bool forceRefresh = false});
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
  Future<void> addNotification({
    required String title,
    required String description,
    required String tagLabel,
    String? timeLabel,
    String? userId,
  });
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final SupabaseClient supabaseClient;

  // In-memory cache notifikasi
  static List<NotificationModel>? _cachedNotifications;
  static DateTime? _cacheTimestamp;
  static const Duration _cacheDuration = Duration(seconds: 30);

  NotificationRemoteDataSourceImpl({SupabaseClient? client})
      : supabaseClient = client ?? Supabase.instance.client;

  static void invalidateCache() {
    _cachedNotifications = null;
    _cacheTimestamp = null;
  }

  @override
  Future<List<NotificationModel>> getNotifications({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cachedNotifications != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheDuration) {
      return List<NotificationModel>.from(_cachedNotifications!);
    }

    try {
      final user = supabaseClient.auth.currentUser;
      dynamic response;

      if (user != null) {
        // Ambil notifikasi personal pengguna ATAU notifikasi broadcast umum (user_id IS NULL)
        response = await supabaseClient
            .from('notifications')
            .select()
            .or('user_id.eq.${user.id},user_id.is.null')
            .order('created_at', ascending: false);
      } else {
        // Pengguna guest/belum login hanya melihat notifikasi broadcast umum
        response = await supabaseClient
            .from('notifications')
            .select()
            .isFilter('user_id', null)
            .order('created_at', ascending: false);
      }

      if (response is List) {
        final list = response
            .map((item) => NotificationModel.fromJson(item as Map<String, dynamic>))
            .toList();
        _cachedNotifications = List<NotificationModel>.from(list);
        _cacheTimestamp = DateTime.now();
        return list;
      }
      return [];
    } catch (e) {
      debugPrint('Error fetch notifications dari Supabase: $e');
      return _cachedNotifications != null ? List<NotificationModel>.from(_cachedNotifications!) : [];
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await supabaseClient
          .from('notifications')
          .update({'is_unread': false})
          .eq('id', id);
    } catch (e) {
      debugPrint('Error markAsRead notification: $e');
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user != null) {
        await supabaseClient
            .from('notifications')
            .update({'is_unread': false})
            .eq('user_id', user.id);
      }
    } catch (e) {
      debugPrint('Error markAllAsRead notifications: $e');
    }
  }

  @override
  Future<void> addNotification({
    required String title,
    required String description,
    required String tagLabel,
    String? timeLabel,
    String? userId,
  }) async {
    try {
      await supabaseClient.from('notifications').insert({
        if (userId != null) 'user_id': userId,
        'title': title,
        'description': description,
        'tag_label': tagLabel,
        'time_label': timeLabel ?? 'Baru saja',
        'is_unread': true,
      });
    } catch (e) {
      debugPrint('Error insert notification ke Supabase: $e');
    }
  }
}
