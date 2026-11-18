import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoaxcheck_app/features/splash/pages/splash_page.dart';
import 'package:hoaxcheck_app/features/splash/widgets/splash_footer.dart';
import 'package:hoaxcheck_app/features/splash/widgets/splash_loading.dart';

void main() {
  testWidgets('SplashFooter does not overflow on a 360 wide screen', (tester) async {
    FlutterErrorDetails? errorDetails;
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      errorDetails = details;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SplashFooter(
              isDark: false,
              primaryColor: Color(0xFF006B4D),
            ),
          ),
        ),
      ),
    );

    expect(errorDetails, isNull);
  });

  testWidgets('SplashFooter does not overflow on a 320 wide screen', (tester) async {
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
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SplashFooter(
              isDark: false,
              primaryColor: Color(0xFF006B4D),
            ),
          ),
        ),
      ),
    );

    expect(errorDetails, isNull);
  });

  testWidgets('SplashLoading does not overflow on a 320 wide screen', (tester) async {
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
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SplashLoading(
              progressAnimation: AlwaysStoppedAnimation(0.5),
              isDark: false,
              primaryColor: Color(0xFF006B4D),
            ),
          ),
        ),
      ),
    );

    expect(errorDetails, isNull);
  });

  testWidgets('SplashPage does not overflow at various animation frames on 360x640', (tester) async {
    FlutterErrorDetails? errorDetails;
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      errorDetails = details;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: SplashPage(),
      ),
    );

    for (int i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 200));
      if (errorDetails != null) break;
    }

    expect(errorDetails, isNull);
  });

  testWidgets('SplashPage does not overflow on small 320x568 screen', (tester) async {
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
        home: SplashPage(),
      ),
    );

    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 200));
      if (errorDetails != null) break;
    }

    expect(errorDetails, isNull);
  });

  testWidgets('SplashPage does not overflow in landscape (640x360)', (tester) async {
    FlutterErrorDetails? errorDetails;
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      errorDetails = details;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    tester.view.physicalSize = const Size(640, 360);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: SplashPage(),
      ),
    );

    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 200));
      if (errorDetails != null) break;
    }

    expect(errorDetails, isNull);
  });

  testWidgets('SplashPage does not overflow on small height screen (360x480)', (tester) async {
    FlutterErrorDetails? errorDetails;
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      errorDetails = details;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    tester.view.physicalSize = const Size(360, 480);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: SplashPage(),
      ),
    );

    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 200));
      if (errorDetails != null) break;
    }

    expect(errorDetails, isNull);
  });

  testWidgets('SplashPage does not overflow with high text scaling (1.4x)', (tester) async {
    FlutterErrorDetails? errorDetails;
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      errorDetails = details;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(1.4),
            size: Size(360, 640),
          ),
          child: const SplashPage(),
        ),
      ),
    );

    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 200));
      if (errorDetails != null) break;
    }

    expect(errorDetails, isNull);
  });
}
