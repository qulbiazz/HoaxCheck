import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/profile/presentation/pages/laporkan_masalah_page.dart';

void main() {
  group('LaporkanMasalahPage Widget Tests', () {
    testWidgets('menampilkan komponen form pelaporan masalah', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LaporkanMasalahPage(),
        ),
      );

      expect(find.text('Laporkan Masalah'), findsOneWidget);
      expect(find.text('Jenis Masalah'), findsOneWidget);
      expect(find.text('Deskripsi Masalah'), findsOneWidget);
      expect(find.text('Email Kamu'), findsOneWidget);
      expect(find.text('Kirim Laporan'), findsOneWidget);
    });

    testWidgets('menampilkan notifikasi jika tombol ditekan saat form belum lengkap', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: LaporkanMasalahPage(),
        ),
      );

      final kirimBtn = find.text('Kirim Laporan');
      await tester.ensureVisible(kirimBtn);
      await tester.tap(kirimBtn);
      await tester.pump();

      expect(find.text('Harap pilih jenis masalah terlebih dahulu'), findsOneWidget);
    });
  });
}
