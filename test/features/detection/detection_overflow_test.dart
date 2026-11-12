import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/detection/presentation/pages/detection_page.dart';

void main() {
  testWidgets('DetectionPage does not overflow on a 360x640 mobile screen', (tester) async {
    FlutterErrorDetails? errorDetails;
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      errorDetails = details;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    // Ukuran layar mobile standar (misal: 360 x 640 dp)
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: DetectionPage(),
      ),
    );

    await tester.pumpAndSettle();

    final exception = tester.takeException();
    if (errorDetails != null) {
      debugPrint('SUMMARY: ${errorDetails!.summary}');
      for (final prop in errorDetails!.informationCollector!()) {
        debugPrint('PROP: ${prop.value}');
      }
    }
    expect(exception, isNull);
  });

  testWidgets('DetectionPage does not overflow on a small 320x568 screen', (tester) async {
    FlutterErrorDetails? errorDetails;
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      errorDetails = details;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: DetectionPage(),
      ),
    );

    await tester.pumpAndSettle();

    final exception = tester.takeException();
    if (errorDetails != null) {
      debugPrint('SUMMARY 320: ${errorDetails!.summary}');
      for (final prop in errorDetails!.informationCollector!()) {
        debugPrint('PROP 320: ${prop.value}');
      }
    }
    expect(exception, isNull);
  });
}
