import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../widgets/laporkan/laporkan_hero_card.dart';
import '../widgets/laporkan/laporkan_form.dart';
import '../widgets/laporkan/laporkan_dukungan_card.dart';
import '../widgets/laporkan/laporkan_footer.dart';

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
  }

  @override
  void dispose() {
    _deskripsiController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateFormState() {
    setState(() {}); // trigger rebuild untuk refresh tombol
  }

  /// Cek apakah form valid untuk tombol aktif
  bool get _isFormValid {
    final kategoriOk = _selectedKategori != null;
    final deskripsiOk = _deskripsiController.text.trim().length >= 10;
    final email = _emailController.text.trim();
    final emailOk = email.isEmpty || _isValidEmail(email);
    return kategoriOk && deskripsiOk && emailOk;
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  Future<void> _submitLaporan() async {
    // Simulasi loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.of(context).pop(); // close loading

    // Reset form
    setState(() {
      _selectedKategori = null;
      _deskripsiController.clear();
      _emailController.clear();
    });

    // Snackbar sukses
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Laporan berhasil dikirim. Terima kasih!"),
        duration: Duration(seconds: 2),
      ),
    );
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

              // Tombol Kirim Laporan (auto-disable)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isFormValid ? _submitLaporan : null,
                  icon: const Icon(
                    Icons.send_outlined,
                    size: 16,
                  ),
                  label: const Text(
                    "Kirim Laporan",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0),
                    disabledForegroundColor: isDark
                        ? Colors.white38
                        : AppColors.neutral,
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