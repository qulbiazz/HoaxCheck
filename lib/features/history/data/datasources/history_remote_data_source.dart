import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/history_item_model.dart';

abstract class HistoryRemoteDataSource {
  Future<List<HistoryItemModel>> getUserHistories({bool forceRefresh = false});
  Future<void> saveHistory(HistoryItemModel item);
  Future<void> deleteHistory(String id);
  Future<void> clearAllHistory();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final SupabaseClient supabaseClient;

  // In-memory cache untuk performa tinggi & eliminasi round-trip ganda
  static List<HistoryItemModel>? _cachedHistory;
  static DateTime? _cacheTimestamp;
  static const Duration _cacheDuration = Duration(seconds: 45);
  static bool _hasCleanedOldHistories = false;

  HistoryRemoteDataSourceImpl({SupabaseClient? client})
      : supabaseClient = client ?? Supabase.instance.client;

  /// Utility untuk mereset cache saat force refresh atau pengujian
  static void invalidateCache() {
    _cachedHistory = null;
    _cacheTimestamp = null;
  }

  @override
  Future<List<HistoryItemModel>> getUserHistories({bool forceRefresh = false}) async {
    // 1. Cek in-memory cache jika tidak dipaksa refresh
    if (!forceRefresh &&
        _cachedHistory != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheDuration) {
      return List<HistoryItemModel>.from(_cachedHistory!);
    }

    final userId = supabaseClient.auth.currentUser?.id;

    try {
      // Auto-cleanup data riwayat yang telah melampaui masa retensi 30 hari di background (non-blocking)
      if (!_hasCleanedOldHistories) {
        _hasCleanedOldHistories = true;
        Future.microtask(() async {
          try {
            final thirtyDaysAgo =
                DateTime.now().subtract(const Duration(days: 30));
            await supabaseClient
                .from('user_histories')
                .delete()
                .lt('tested_at', thirtyDaysAgo.toIso8601String());
          } catch (_) {}
        });
      }

      List<dynamic> rows = [];

      // 1. Coba ambil riwayat spesifik milik user yang sedang login jika ada
      if (userId != null) {
        try {
          final response = await supabaseClient
              .from('user_histories')
              .select()
              .eq('user_id', userId)
              .gte('tested_at', DateTime.now().subtract(const Duration(days: 30)).toIso8601String())
              .order('tested_at', ascending: false);

          if (response.isNotEmpty) {
            rows = response;
          }
        } catch (_) {
          // Kolom user_id belum ada di Supabase, fallback ambil semua data
        }
      }

      // 2. Ambil semua data riwayat jika belum didapatkan
      if (rows.isEmpty) {
        final response = await supabaseClient
            .from('user_histories')
            .select()
            .gte('tested_at', DateTime.now().subtract(const Duration(days: 30)).toIso8601String())
            .order('tested_at', ascending: false);
        rows = response;
      }

      // 3. Deduplikasi cerdas: membersihkan riwayat kembar / duplikat
      final List<HistoryItemModel> cleanItems = [];
      for (final row in rows) {
        final item = HistoryItemModel.fromMap(row);
        final isDuplicate = cleanItems.any((existing) =>
            existing.snippet.trim() == item.snippet.trim() &&
            existing.isHoax == item.isHoax &&
            (existing.time == item.time || (existing.id != null && existing.id == item.id)));

        if (!isDuplicate) {
          cleanItems.add(item);
        }
      }

      // Simpan ke in-memory cache
      _cachedHistory = List<HistoryItemModel>.from(cleanItems);
      _cacheTimestamp = DateTime.now();

      return cleanItems;
    } catch (e) {
      debugPrint('Info HistoryRemoteDataSource: $e');
      return _cachedHistory != null ? List<HistoryItemModel>.from(_cachedHistory!) : [];
    }
  }

  @override
  Future<void> saveHistory(HistoryItemModel item) async {
    final userId = supabaseClient.auth.currentUser?.id;
    final map = item.toSupabaseMap(userId);

    // Update cache secara optimistik
    if (_cachedHistory != null) {
      _cachedHistory!.insert(0, item);
      _cacheTimestamp = DateTime.now();
    }

    try {
      await supabaseClient.from('user_histories').insert(map);
    } catch (e) {
      // Jika kolom user_id belum dibuat di database Supabase, fallback tanpa user_id
      try {
        final fallbackMap = Map<String, dynamic>.from(map)..remove('user_id');
        await supabaseClient.from('user_histories').insert(fallbackMap);
      } catch (innerError) {
        debugPrint('Gagal simpan riwayat: $innerError');
      }
    }
  }

  @override
  Future<void> deleteHistory(String id) async {
    // Update cache lokal langsung
    if (_cachedHistory != null) {
      _cachedHistory!.removeWhere((item) => item.id == id);
      _cacheTimestamp = DateTime.now();
    }
    await supabaseClient.from('user_histories').delete().eq('id', id);
  }

  @override
  Future<void> clearAllHistory() async {
    _cachedHistory = [];
    _cacheTimestamp = DateTime.now();
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId != null) {
      try {
        await supabaseClient.from('user_histories').delete().eq('user_id', userId);
        return;
      } catch (_) {}
    }
    await supabaseClient.from('user_histories').delete().neq('id', '0');
  }
}
