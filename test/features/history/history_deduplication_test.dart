import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/history/data/datasources/history_remote_data_source.dart';
import 'package:hoaxcheck_app/features/history/data/models/history_item_model.dart';

void main() {
  group('History Deduplication Tests', () {
    test('Deduplikasi membersihkan riwayat kembar yang masuk dalam waktu bersamaan', () {
      final rawRows = [
        {
          'id': 'uuid-1',
          'title': 'Bansos cair hari ini',
          'snippet': 'Bansos cair hari ini daftar segera',
          'is_hoax': true,
          'confidence_str': '95%',
          'classification': 'Terindikasi Hoaks',
          'source': 'Bernoulli Naive Bayes',
          'tested_at': DateTime.now().toIso8601String(),
        },
        {
          'id': 'uuid-2',
          'title': 'Bansos cair hari ini',
          'snippet': 'Bansos cair hari ini daftar segera',
          'is_hoax': true,
          'confidence_str': '95%',
          'classification': 'Terindikasi Hoaks',
          'source': 'Bernoulli Naive Bayes',
          'tested_at': DateTime.now().toIso8601String(),
        },
        {
          'id': 'uuid-3',
          'title': 'Berita Resmi BMKG',
          'snippet': 'Prakiraan cuaca wilayah Jabodetabek',
          'is_hoax': false,
          'confidence_str': '98%',
          'classification': 'Informasi Valid',
          'source': 'Bernoulli Naive Bayes',
          'tested_at': DateTime.now().toIso8601String(),
        },
      ];

      final List<HistoryItemModel> cleanItems = [];
      for (final row in rawRows) {
        final item = HistoryItemModel.fromMap(row);
        final isDuplicate = cleanItems.any((existing) =>
            existing.snippet.trim() == item.snippet.trim() &&
            existing.isHoax == item.isHoax &&
            (existing.time == item.time || (existing.id != null && existing.id == item.id)));

        if (!isDuplicate) {
          cleanItems.add(item);
        }
      }

      // Dari 3 baris data (di mana ada 2 baris duplikat bansos), harus tersisa tepat 2 item unik
      expect(cleanItems.length, equals(2));
      expect(cleanItems[0].snippet, equals('Bansos cair hari ini daftar segera'));
      expect(cleanItems[1].snippet, equals('Prakiraan cuaca wilayah Jabodetabek'));
    });
  });
}
