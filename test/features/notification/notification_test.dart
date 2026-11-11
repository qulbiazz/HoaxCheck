import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/notification/data/models/notification_model.dart';
import 'package:hoaxcheck_app/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:hoaxcheck_app/features/notification/presentation/pages/notification_page.dart';

class FakeNotificationRepository implements NotificationRepository {
  List<NotificationModel> fakeItems;

  FakeNotificationRepository(this.fakeItems);

  @override
  Future<List<NotificationModel>> getNotifications() async => fakeItems;

  @override
  Future<void> markAsRead(String id) async {
    fakeItems = fakeItems.map((n) {
      if (n.id == id) return n.copyWith(isUnread: false);
      return n;
    }).toList();
  }

  @override
  Future<void> markAllAsRead() async {
    fakeItems = fakeItems.map((n) => n.copyWith(isUnread: false)).toList();
  }

  @override
  Future<void> addNotification({
    required String title,
    required String description,
    required String tagLabel,
    String? timeLabel,
    String? userId,
  }) async {
    fakeItems.insert(
      0,
      NotificationModel(
        id: 'new-id',
        userId: userId,
        title: title,
        description: description,
        timeLabel: timeLabel ?? 'Baru saja',
        tagLabel: tagLabel,
        isUnread: true,
      ),
    );
  }
}

void main() {
  group('NotificationModel Tests', () {
    test('parsing JSON dengan benar dan menghasilkan display tags sesuai kategori', () {
      final json = {
        'id': 'notif-1',
        'title': 'Waspada Hoaks Bansos Beredar',
        'description': 'Pesan berantai bantuan kuota di WhatsApp.',
        'time_label': 'Baru saja',
        'tag_label': 'Waspada Hoaks',
        'is_unread': true,
        'created_at': DateTime.now().toIso8601String(),
      };

      final model = NotificationModel.fromJson(json);
      expect(model.id, 'notif-1');
      expect(model.title, 'Waspada Hoaks Bansos Beredar');
      expect(model.isUnread, isTrue);
      expect(model.tagLabel, 'Waspada Hoaks');
      expect(model.icon, Icons.warning_amber_rounded);
      expect(model.groupCategory, 'HARI INI');
    });

    test('parsing tag Verifikasi Teks menghasilkan ikon checklist/verified', () {
      final json = {
        'id': 'notif-2',
        'title': 'Hasil Analisis: Informasi Valid',
        'description': 'Teks selesai diuji.',
        'tag_label': 'Verifikasi Teks',
        'is_unread': false,
      };

      final model = NotificationModel.fromJson(json);
      expect(model.icon, Icons.verified_outlined);
    });

    test('parsing tag Tanggapan Tim menghasilkan ikon customer support / read chat', () {
      final json = {
        'id': 'notif-3',
        'title': 'Laporan Ditanggapi',
        'description': 'Masalah telah diselesaikan.',
        'tag_label': 'Tanggapan Tim',
        'is_unread': true,
      };

      final model = NotificationModel.fromJson(json);
      expect(model.icon, Icons.mark_chat_read_outlined);
    });
  });

  group('NotificationPage Widget Tests', () {
    testWidgets('menampilkan notifikasi dari repository dan merender kartu notifikasi', (tester) async {
      final fakeRepo = FakeNotificationRepository([
        NotificationModel(
          id: '1',
          title: 'Alert Hoaks Terkini',
          description: 'Pesan hoaks pendaftaran bansos beredar di medsos.',
          timeLabel: 'Baru saja',
          tagLabel: 'Waspada Hoaks',
          isUnread: true,
          createdAt: DateTime.now(),
        ),
        NotificationModel(
          id: '2',
          title: 'Analisis Selesai',
          description: 'Hasil deteksi artikel telah tersedia di riwayat.',
          timeLabel: '1 jam lalu',
          tagLabel: 'Verifikasi Teks',
          isUnread: false,
          createdAt: DateTime.now(),
        ),
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: NotificationPage(repository: fakeRepo),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Notifikasi'), findsOneWidget);
      expect(find.text('Alert Hoaks Terkini'), findsOneWidget);
      expect(find.text('Analisis Selesai'), findsOneWidget);
      expect(find.text('Waspada Hoaks'), findsOneWidget);
      expect(find.text('Verifikasi Teks'), findsOneWidget);
    });

    testWidgets('menampilkan empty state jika tidak ada notifikasi', (tester) async {
      final fakeRepo = FakeNotificationRepository([]);

      await tester.pumpWidget(
        MaterialApp(
          home: NotificationPage(repository: fakeRepo),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Belum Ada Pemberitahuan'), findsOneWidget);
    });
  });
}
