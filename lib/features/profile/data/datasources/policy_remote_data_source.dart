import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/policy_model.dart';

// Ini adalah "kontrak" (interface). Nanti kalau ada implementasi lain (misal ambil dari API lain), 
// kita tinggal ikutin aturan di sini.
abstract class PolicyRemoteDataSource {
  Future<PolicyModel?> getPolicyByType(String type);
}

// Ini implementasi aslinya yang ngobrol langsung sama Supabase
class PolicyRemoteDataSourceImpl implements PolicyRemoteDataSource {
  final SupabaseClient supabaseClient;

  PolicyRemoteDataSourceImpl({SupabaseClient? client})
      : supabaseClient = client ?? Supabase.instance.client;

  @override
  Future<PolicyModel?> getPolicyByType(String type) async {
    try {
      // Mengambil 1 baris data (maybeSingle) dari tabel 'app_policies'
      // yang kolom 'type'-nya sama dengan parameter (misal: 'privacy')
      final response = await supabaseClient
          .from('app_policies')
          .select()
          .eq('type', type)
          .maybeSingle();

      // Kalau datanya ada di database, ubah jadi bentuk PolicyModel
      if (response != null) {
        return PolicyModel.fromMap(response);
      }
      
      // Kalau datanya kosong (belum diinput), kembalikan null
      return null;
    } catch (e) {
      // Kalau tabel belum dibuat atau error koneksi, lempar pesannya
      throw Exception('Gagal mengambil data kebijakan: $e');
    }
  }
}