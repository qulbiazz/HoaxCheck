import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../app/theme.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class EditProfilePage extends StatefulWidget {
  final AuthRepository? authRepository;
  final ImagePicker? imagePicker;

  const EditProfilePage({
    super.key,
    this.authRepository,
    this.imagePicker,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final AuthRepository _authRepository;
  late TextEditingController _nameController;
  String _userEmail = "qulbi@hoaxcheck.id";
  String? _avatarUrl;
  Uint8List? _selectedImageBytes;
  String? _selectedFileName;
  bool _isAvatarRemoved = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authRepository = widget.authRepository ?? AuthRepositoryImpl();
    final user = _authRepository.getCurrentUserSync();
    final initialName = (user?.name != null && user!.name!.trim().isNotEmpty)
        ? user.name!
        : "Qulbi Khutsi Azzumi";
    _nameController = TextEditingController(text: initialName);
    if (user?.email != null && user!.email.isNotEmpty) {
      _userEmail = user.email;
    }
    _avatarUrl = user?.avatarUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _showPhotoSourceBottomSheet() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final hasActiveAvatar = _selectedImageBytes != null ||
            (!_isAvatarRemoved && _avatarUrl != null && _avatarUrl!.trim().isNotEmpty);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white24 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "Pilih Foto Profil",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Pilih foto dari galeri atau ambil foto baru dengan kamera",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppDarkColors.textSecondary : AppColors.neutral,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.photo_library_outlined, color: AppColors.primary),
                  ),
                  title: Text(
                    "Pilih dari Galeri",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
                    ),
                  ),
                  subtitle: const Text("Pilih gambar dari galeri perangkat"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt_outlined, color: AppColors.primary),
                  ),
                  title: Text(
                    "Ambil dari Kamera",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
                    ),
                  ),
                  subtitle: const Text("Gunakan kamera untuk mengambil foto"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
                if (hasActiveAvatar) ...[
                  const Divider(height: 20),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.delete_outline, color: AppColors.danger),
                    ),
                    title: const Text(
                      "Hapus Foto Profil",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.danger,
                      ),
                    ),
                    subtitle: const Text("Kembalikan ke inisial / avatar default"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      setState(() {
                        _selectedImageBytes = null;
                        _selectedFileName = null;
                        _isAvatarRemoved = true;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = widget.imagePicker ?? ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        final resolvedName = image.name.isNotEmpty
            ? image.name
            : (image.path.isNotEmpty
                ? image.path.split('/').last.split('\\').last
                : 'avatar.jpg');
        setState(() {
          _selectedImageBytes = bytes;
          _selectedFileName = resolvedName.isNotEmpty ? resolvedName : 'avatar.jpg';
          _isAvatarRemoved = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih gambar: $e'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  Future<void> _handleSaveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama lengkap tidak boleh kosong'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      String? newAvatarUrl = _avatarUrl;

      // 1. Jika ada foto baru yang dipilih, unggah ke Supabase Storage bucket 'avatars'
      if (_selectedImageBytes != null) {
        newAvatarUrl = await _authRepository.uploadAvatar(
          bytes: _selectedImageBytes!,
          fileName: _selectedFileName ?? 'avatar.jpg',
        );
      } else if (_isAvatarRemoved) {
        newAvatarUrl = '';
      }

      // 2. Simpan pembaruan profil pengguna ke Supabase
      await _authRepository.updateProfile(
        name: name,
        avatarUrl: newAvatarUrl,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil dan foto berhasil diperbarui'),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan profil: $e'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: isDark ? AppDarkColors.textPrimary : AppColors.inverted,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    InkWell(
                      onTap: _isLoading ? null : _showPhotoSourceBottomSheet,
                      borderRadius: BorderRadius.circular(50),
                      child: Stack(
                        children: [
                          UserAvatar(
                            avatarUrl: _isAvatarRemoved ? null : _avatarUrl,
                            imageBytes: _selectedImageBytes,
                            size: 90,
                            borderWidth: 3,
                            borderColor: isDark ? AppDarkColors.border : Colors.white,
                            shadow: const BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: _isLoading ? null : _showPhotoSourceBottomSheet,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.photo_camera_outlined,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Ubah Foto Profil",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                "Nama Lengkap",
                style: TextStyle(
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF334155),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppDarkColors.border : const Color(0xFFE2E8F0),
                  ),
                ),
                child: TextField(
                  controller: _nameController,
                  style: TextStyle(
                    color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: isDark ? AppDarkColors.textSecondary : const Color(0xFFCBD5E1),
                        size: 18,
                      ),
                      onPressed: () {
                        _nameController.clear();
                      },
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Alamat Email",
                    style: TextStyle(
                      color: isDark ? AppDarkColors.textSecondary : const Color(0xFF334155),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 12,
                        color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Terkunci",
                        style: TextStyle(
                          color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppDarkColors.surface.withValues(alpha: 0.6)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppDarkColors.border : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.alternate_email_rounded,
                      color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _userEmail,
                        style: TextStyle(
                          color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 13,
                    color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Email akun terdaftar tidak dapat diubah",
                    style: TextStyle(
                      color: isDark ? AppDarkColors.textSecondary : const Color(0xFF64748B),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Status Literasi",
                style: TextStyle(
                  color: isDark ? AppDarkColors.textSecondary : const Color(0xFF334155),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppDarkColors.surface : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppDarkColors.border : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Pengguna Aktif Komunitas",
                      style: TextStyle(
                        color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(
                    Icons.shield_outlined,
                    size: 13,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Tingkat Kontributor: Verifikator Independen",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSaveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.check, size: 18, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Simpan Perubahan",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFDBEAFE),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_person_outlined,
                      color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6),
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Informasi profil disinkronkan dengan akun cloud Anda secara aman untuk personalisasi pengalaman aplikasi.",
                        style: TextStyle(
                          color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E40AF),
                          fontSize: 11.5,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
