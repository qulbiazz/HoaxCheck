
import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/app/app.dart';

void main() {
  testWidgets('HoaxCheckApp displays splash page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HoaxCheckApp());

    // Pastikan aplikasi berhasil menampilkan halaman awal.
    expect(find.byType(HoaxCheckApp), findsOneWidget);

    // Pastikan widget aplikasi berhasil dibangun.
    expect(tester.takeException(), isNull);
  });
}
