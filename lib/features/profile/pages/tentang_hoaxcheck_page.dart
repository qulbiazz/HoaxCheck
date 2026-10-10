import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../widgets/tentang/tentang_header_section.dart';
import '../widgets/tentang/tentang_profile_card.dart';
import '../widgets/tentang/tentang_apa_itu_section.dart';
import '../widgets/tentang/tentang_cara_kerja_section.dart';
import '../widgets/tentang/tentang_memahami_hasil_section.dart';
import '../widgets/tentang/tentang_disclaimer_section.dart';

class TentangHoaxCheckPage extends StatelessWidget {
  const TentangHoaxCheckPage({super.key});

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
          "Tentang HoaxCheck",
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
            children: const [
              TentangHeaderSection(),
              SizedBox(height: 28),
              TentangProfileCard(),
              SizedBox(height: 28),
              TentangApaItuSection(),
              SizedBox(height: 24),
              TentangCaraKerjaSection(),
              SizedBox(height: 24),
              TentangMemahamiHasilSection(),
              SizedBox(height: 24),
              TentangDisclaimerSection(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}