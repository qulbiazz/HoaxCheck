import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hoaxcheck_app/core/widgets/user_avatar.dart';
import 'package:hoaxcheck_app/features/auth/data/models/user_model.dart';
import 'package:hoaxcheck_app/app/app_header.dart';

void main() {
  group('UserModel Avatar Parsing', () {
    test('mengambil avatar dari metadata avatar_url', () {
      final user = User(
        id: 'user-123',
        appMetadata: {},
        userMetadata: {
          'full_name': 'Google User',
          'avatar_url': 'https://lh3.googleusercontent.com/a/avatar123',
        },
        aud: 'authenticated',
        createdAt: '2026-01-01T00:00:00Z',
      );

      final model = UserModel.fromSupabase(user);
      expect(model.name, 'Google User');
      expect(model.avatarUrl, 'https://lh3.googleusercontent.com/a/avatar123');
    });

    test('mengambil avatar dari metadata picture (standar Google OAuth)', () {
      final user = User(
        id: 'user-456',
        appMetadata: {},
        userMetadata: {
          'name': 'Google OAuth User',
          'picture': 'https://lh3.googleusercontent.com/a/picture456',
        },
        aud: 'authenticated',
        createdAt: '2026-01-01T00:00:00Z',
      );

      final model = UserModel.fromSupabase(user);
      expect(model.name, 'Google OAuth User');
      expect(model.avatarUrl, 'https://lh3.googleusercontent.com/a/picture456');
    });

    test('menghasilkan avatarUrl null jika akun register biasa tanpa avatar', () {
      final user = User(
        id: 'user-789',
        appMetadata: {},
        userMetadata: {
          'full_name': 'Pendaftar Aplikasi',
        },
        aud: 'authenticated',
        createdAt: '2026-01-01T00:00:00Z',
      );

      final model = UserModel.fromSupabase(user);
      expect(model.name, 'Pendaftar Aplikasi');
      expect(model.avatarUrl, isNull);
    });
  });

  group('UserAvatar Widget', () {
    testWidgets('menampilkan default avatar icon jika avatarUrl bernilai null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(avatarUrl: null, size: 36),
          ),
        ),
      );

      expect(find.byIcon(Icons.person_rounded), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('menampilkan default avatar icon jika avatarUrl string kosong', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(avatarUrl: '   ', size: 36),
          ),
        ),
      );

      expect(find.byIcon(Icons.person_rounded), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('merender Image.network jika avatarUrl valid (akun Google)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://lh3.googleusercontent.com/a/photo.jpg',
              size: 36,
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('merender Image.memory jika imageBytes disediakan (preview upload lokal)', (tester) async {
      final transparentImage = Uint8List.fromList(<int>[
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
        0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
        0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
        0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
        0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
        0x60, 0x82,
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              imageBytes: transparentImage,
              size: 50,
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });
  });

  group('AppHeader Widget', () {
    testWidgets('merender AppHeader dengan judul dan UserAvatar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: AppHeader(title: 'Beranda'),
          ),
        ),
      );

      expect(find.text('Beranda'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.byType(UserAvatar), findsOneWidget);
    });
  });
}
