import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/history_item_model.dart';

abstract class HistoryRemoteDataSource {
  Future<List<HistoryItemModel>> getUserHistories();
  Future<void> saveHistory(HistoryItemModel item);
  Future<void> deleteHistory(String id);
  Future<void> clearAllHistory();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final SupabaseClient supabaseClient;

  HistoryRemoteDataSourceImpl({SupabaseClient? client})
      : supabaseClient = client ?? Supabase.instance.client;

  @override
  Future<List<HistoryItemModel>> getUserHistories() async {
    final userId = supabaseClient.auth.currentUser?.id;

    try {
      // 1. Coba ambil riwayat spesifik milik user yang sedang login jika ada
      if (userId != null) {
        try {
          final response = await supabaseClient
              .from('user_histories')
              .select()
              .eq('user_id', userId)
              .order('tested_at', ascending: false);

          if (response.isNotEmpty) {
            return response
                .map((row) => HistoryItemModel.fromMap(row))
                .toList();
          }
        } catch (_) {
          // Kolom user_id belum ada di Supabase, fallback ambil semua data
        }
      }

      // 2. Ambil semua data riwayat yang tersedia
      final response = await supabaseClient
          .from('user_histories')
          .select()
          .order('tested_at', ascending: false);

      return response
          .map((row) => HistoryItemModel.fromMap(row))
          .toList();
    } catch (e) {
      debugPrint('Info HistoryRemoteDataSource: $e');
      return [];
    }
  }

  @override
  Future<void> saveHistory(HistoryItemModel item) async {
    final userId = supabaseClient.auth.currentUser?.id;
    final map = item.toSupabaseMap(userId);

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
    await supabaseClient.from('user_histories').delete().eq('id', id);
  }

  @override
  Future<void> clearAllHistory() async {
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
