import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../app/theme.dart';
import '../widgets/laporkan/laporkan_dukungan_card.dart';
import '../widgets/laporkan/laporkan_footer.dart';
import '../widgets/laporkan/laporkan_form.dart';
import '../widgets/laporkan/laporkan_hero_card.dart';

class LaporkanMasalahPage extends StatefulWidget {
  const LaporkanMasalahPage({super.key});

  @override
  State<LaporkanMasalahPage> createState() => _LaporkanMasalahPageState();
}

class _LaporkanMasalahPageState extends State<LaporkanMasalahPage> {
  // Controllers
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // State
  String? _selectedKategori;

  @override
  void initState() {
    super.initState();
    // Dengarkan perubahan input untuk update tombol
    _deskripsiController.addListener(_updateFormState);
    _emailController.addListener(_updateFormState);
    _prefillUserEmail();
  }

  void _prefillUserEmail() {
    try {
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser?.email != null && currentUser!.email!.isNotEmpty) {
        _emailController.text = currentUser.email!;
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _deskripsiController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateFormState() {
    setState(() {}); // trigger rebuild untuk refresh status visual tombol
  }

  /// Cek apakah form valid untuk tombol aktif
  bool get _isFormValid {
    final kategoriOk = _selectedKategori != null && _selectedKategori!.trim().isNotEmpty;
    final deskripsiOk = _deskripsiController.text.trim().isNotEmpty;
    final email = _emailController.text.trim();
    final emailOk = email.isEmpty || _isValidEmail(email);
    return kategoriOk && deskripsiOk && emailOk;
  }

  bool _isValidEmail(String email) {
    final cleanEmail = email.trim();
    if (cleanEmail.isEmpty) return true;
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(cleanEmail);
  }

  void _handlePressKirim() {
    if (_selectedKategori == null || _selectedKategori!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap pilih jenis masalah terlebih dahulu"),
          backgroundColor: AppColors.danger,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_deskripsiController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi deskripsi masalah terlebih dahulu"),
          backgroundColor: AppColors.danger,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final email = _emailController.text.trim();
    if (email.isNotEmpty && !_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Format email tidak valid (contoh: nama@domain.com)"),
          backgroundColor: AppColors.danger,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    _submitLaporan();
  }

  Future<void> _submitLaporan() async {
    // Tampilkan loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final kategori = _selectedKategori;
    final deskripsi = _deskripsiController.text.trim();
    final email = _emailController.text.trim();

    bool success = true;
    String errorMessage = '';

    try {
      final user = Supabase.instance.client.auth.currentUser;
      await Supabase.instance.client.from('problem_reports').insert({
        if (user != null) 'user_id': user.id,
        'kategori': kategori,
        'deskripsi': deskripsi,
        if (email.isNotEmpty) 'email': email,
      });
    } catch (e) {
      debugPrint('Catatan insert problem_reports ke Supabase: $e');
      success = false;
      errorMessage = e.toString();
    }

    if (!mounted) return;
    Navigator.of(context).pop(); // close loading

    if (success) {
      // Reset form
      setState(() {
        _selectedKategori = null;
        _deskripsiController.clear();
        _prefillUserEmail();
      });

      // Snackbar sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Laporan berhasil dikirim ke server. Terima kasih!"),
          backgroundColor: AppColors.primary,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal mengirim laporan: $errorMessage"),
          backgroundColor: AppColors.danger,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppDarkColors.neutral : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppDarkColors.surface : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.inverted,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          "Laporkan Masalah",
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.inverted,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero card
              const LaporkanHeroCard(),
              const SizedBox(height: 24),

              // Form
              LaporkanForm(
                selectedKategori: _selectedKategori,
                onKategoriChanged: (value) {
                  setState(() {
                    _selectedKategori = value;
                  });
                },
                deskripsiController: _deskripsiController,
                emailController: _emailController,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _handlePressKirim,
                  icon: const Icon(Icons.send_outlined, size: 16),
                  label: const Text(
                    "Kirim Laporan",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid
                        ? AppColors.primary
                        : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
                    foregroundColor: _isFormValid
                        ? Colors.white
                        : (isDark ? Colors.white54 : const Color(0xFF64748B)),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Card Dukungan Komunitas
              const LaporkanDukunganCard(),
              const SizedBox(height: 20),

              // Footer
              const LaporkanFooter(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
