import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hoaxcheck_app/features/auth/domain/entities/user_entity.dart';
import 'package:hoaxcheck_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hoaxcheck_app/features/profile/presentation/pages/edit_profile_page.dart';

class FakeAuthRepository implements AuthRepository {
  UserEntity? user;
  String? lastUpdatedName;
  String? lastUpdatedAvatarUrl;
  Uint8List? lastUploadedBytes;
  String? lastUploadedFileName;

  FakeAuthRepository({this.user});

  @override
  UserEntity? getCurrentUserSync() => user;

  @override
  Future<UserEntity?> getCurrentUser() async => user;

  @override
  Future<UserEntity> loginWithEmail(String email, String password) async => user!;

  @override
  Future<UserEntity> registerWithEmail(String email, String password, String name) async => user!;

  @override
  Future<void> signInWithGoogle({String? redirectTo}) async {}

  @override
  Future<void> signOut() async {}

  @override
  Stream<UserEntity?> get authStateChanges => Stream.value(user);

  @override
  Future<UserEntity> updateProfile({String? name, String? avatarUrl}) async {
    lastUpdatedName = name;
    lastUpdatedAvatarUrl = avatarUrl;
    user = UserEntity(
      id: user?.id ?? '123',
      email: user?.email ?? 'test@hoaxcheck.id',
      name: name ?? user?.name,
      avatarUrl: avatarUrl ?? user?.avatarUrl,
    );
    return user!;
  }

  @override
  Future<String> uploadAvatar({required Uint8List bytes, required String fileName}) async {
    lastUploadedBytes = bytes;
    lastUploadedFileName = fileName;
    return 'https://supabase.hoaxcheck.id/storage/v1/object/public/avatars/user-123/avatar.jpg';
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {}
}

class FakeImagePicker extends ImagePicker {
  final XFile? fileToReturn;

  FakeImagePicker({this.fileToReturn});

  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    return fileToReturn;
  }
}

void main() {
  group('EditProfilePage Widget & Upload Tests', () {
    testWidgets('menampilkan komponen edit profil, avatar, dan tombol ubah foto profil', (tester) async {
      final fakeRepo = FakeAuthRepository(
        user: const UserEntity(
          id: 'user-001',
          email: 'budi@hoaxcheck.id',
          name: 'Budi Santoso',
          avatarUrl: null,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: EditProfilePage(authRepository: fakeRepo),
        ),
      );

      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('Budi Santoso'), findsOneWidget);
      expect(find.text('budi@hoaxcheck.id'), findsOneWidget);
      expect(find.text('Ubah Foto Profil'), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
      expect(find.text('Simpan Perubahan'), findsOneWidget);
    });

    testWidgets('membuka modal bottom sheet saat tombol ubah foto profil ditekan', (tester) async {
      final fakeRepo = FakeAuthRepository(
        user: const UserEntity(
          id: 'user-002',
          email: 'siti@hoaxcheck.id',
          name: 'Siti Rahma',
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: EditProfilePage(authRepository: fakeRepo),
        ),
      );

      // Tekan tombol Ubah Foto Profil
      await tester.tap(find.text('Ubah Foto Profil'));
      await tester.pumpAndSettle();

      // Modal Bottom Sheet harus muncul dengan pilihan Galeri & Kamera
      expect(find.text('Pilih Foto Profil'), findsOneWidget);
      expect(find.text('Pilih dari Galeri'), findsOneWidget);
      expect(find.text('Ambil dari Kamera'), findsOneWidget);
    });

    testWidgets('memilih gambar dan menyimpannya ke storage Supabase saat Simpan Perubahan ditekan', (tester) async {
      final fakeRepo = FakeAuthRepository(
        user: const UserEntity(
          id: 'user-003',
          email: 'andi@hoaxcheck.id',
          name: 'Andi Pratama',
        ),
      );

      final dummyBytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      final file = XFile.fromData(
        dummyBytes,
        name: 'my_profile.jpg',
        path: 'my_profile.jpg',
      );
      final fakePicker = FakeImagePicker(
        fileToReturn: file,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: EditProfilePage(
            authRepository: fakeRepo,
            imagePicker: fakePicker,
          ),
        ),
      );

      // Buka bottom sheet
      await tester.tap(find.text('Ubah Foto Profil'));
      await tester.pumpAndSettle();

      // Pilih dari Galeri
      await tester.tap(find.text('Pilih dari Galeri'));
      await tester.pumpAndSettle();

      // Pastikan tombol Simpan Perubahan terlihat di viewport lalu ditekan
      await tester.ensureVisible(find.text('Simpan Perubahan'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan Perubahan'));
      await tester.pumpAndSettle();

      expect(fakeRepo.lastUploadedBytes, equals(dummyBytes));
      expect(fakeRepo.lastUploadedFileName, equals('my_profile.jpg'));
      expect(fakeRepo.lastUpdatedName, equals('Andi Pratama'));
      expect(
        fakeRepo.lastUpdatedAvatarUrl,
        'https://supabase.hoaxcheck.id/storage/v1/object/public/avatars/user-123/avatar.jpg',
      );
    });
  });
}
