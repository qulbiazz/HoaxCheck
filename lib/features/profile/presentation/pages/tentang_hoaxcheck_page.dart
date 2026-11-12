import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../../data/datasources/app_info_remote_data_source.dart';
import '../../data/models/app_info_model.dart';
import '../widgets/tentang/tentang_apa_itu_section.dart';
import '../widgets/tentang/tentang_cara_kerja_section.dart';
import '../widgets/tentang/tentang_disclaimer_section.dart';
import '../widgets/tentang/tentang_header_section.dart';
import '../widgets/tentang/tentang_memahami_hasil_section.dart';

class TentangHoaxCheckPage extends StatefulWidget {
  final AppInfoRemoteDataSource? remoteDataSource;

  const TentangHoaxCheckPage({super.key, this.remoteDataSource});

  @override
  State<TentangHoaxCheckPage> createState() => _TentangHoaxCheckPageState();
}

class _TentangHoaxCheckPageState extends State<TentangHoaxCheckPage> {
  late final AppInfoRemoteDataSource _dataSource;
  AppInfoModel _info = AppInfoModel.defaultInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dataSource = widget.remoteDataSource ?? AppInfoRemoteDataSourceImpl();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    try {
      final data = await _dataSource.getAppInfo();
      if (mounted) {
        setState(() {
          _info = data;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: _loadAppInfo,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                      ),
                    ),
                  ),

                TentangHeaderSection(
                  appName: _info.appName,
                  tagline: _info.tagline,
                  description: _info.headerDescription,
                ),
                const SizedBox(height: 28),

                TentangApaItuSection(
                  aboutText: _info.aboutDescription,
                  pills: _info.pills,
                ),
                const SizedBox(height: 24),

                TentangCaraKerjaSection(
                  steps: _info.steps,
                ),
                const SizedBox(height: 24),

                const TentangMemahamiHasilSection(),
                const SizedBox(height: 24),

                TentangDisclaimerSection(
                  disclaimerText: _info.disclaimerText,
                  appVersion: _info.appVersion,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
