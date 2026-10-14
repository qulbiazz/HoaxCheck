import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/history_item_model.dart';

abstract class HistoryRemoteDataSource {
  Future<List<HistoryItemModel>> getUserHistories();
  Future<void> saveHistory(HistoryItemModel item);
  Future<void> deleteHistory(String id);
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final SupabaseClient supabaseClient;

  HistoryRemoteDataSourceImpl({SupabaseClient? client})
      : supabaseClient = client ?? Supabase.instance.client;

  @override
  Future<List<HistoryItemModel>> getUserHistories() async {
    final response = await supabaseClient
        .from('user_histories')
        .select()
        .order('tested_at', ascending: false);

    return (response as List)
        .map((row) => HistoryItemModel.fromMap(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveHistory(HistoryItemModel item) async {
    final userId = supabaseClient.auth.currentUser?.id;
    await supabaseClient
        .from('user_histories')
        .insert(item.toSupabaseMap(userId));
  }

  @override
  Future<void> deleteHistory(String id) async {
    await supabaseClient.from('user_histories').delete().eq('id', id);
  }
}
