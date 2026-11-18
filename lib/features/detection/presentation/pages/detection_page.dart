import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../app/theme.dart';
import '../../../../app/app_header.dart';
import '../widgets/clipboard_banner.dart';
import '../widgets/detection_input_card.dart';
import '../widgets/info_banners.dart';
import 'google_fact_check_page.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  final TextEditingController _textController = TextEditingController();

  String? _clipboardText;
  bool _isClipboardBannerVisible = false;

  @override
  void initState() {
    super.initState();
    _checkClipboard();
  }

  Future<void> _checkClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);

    if (clipboardData != null &&
        clipboardData.text != null &&
        clipboardData.text!.trim().isNotEmpty) {
      setState(() {
        _clipboardText = clipboardData.text;
        _isClipboardBannerVisible = true;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHeader(title: "Deteksi"),
                const Text(
                  "Masukkan teks yang ingin kamu periksa dengan model Machine Learning terverifikasi.",
                  style: TextStyle(
                    color: AppColors.neutral,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                if (_isClipboardBannerVisible && _clipboardText != null) ...[
                  ClipboardBanner(
                    detectedText: _clipboardText!,
                    onUse: () {
                      setState(() {
                        _textController.text = _clipboardText!;
                        _isClipboardBannerVisible = false;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                ],

                DetectionInputCard(controller: _textController),
                const SizedBox(height: 16),

                // Akses Google Fact Check Tools
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GoogleFactCheckPage(
                          initialQuery: _textController.text.trim().isNotEmpty
                              ? _textController.text.trim()
                              : null,
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: Theme.of(context).brightness == Brightness.dark
                            ? [
                                const Color(0xFF1E293B),
                                const Color(0xFF0F172A),
                              ]
                            : [
                                const Color(0xFFEBF5FF),
                                const Color(0xFFF0FDF4),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF4285F4).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4285F4).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.fact_check_rounded,
                            color: Color(0xFF1A73E8),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 6,
                                children: [
                                  Text(
                                    "Google Fact Check",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : AppColors.inverted,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A73E8)
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      "Tools API",
                                      style: TextStyle(
                                        color: Color(0xFF1A73E8),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "Telusuri arsip klarifikasi & sanggahan resmi dari jejaring pemeriksa fakta terverifikasi.",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppDarkColors.textSecondary
                                      : AppColors.neutral,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Color(0xFF1A73E8),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const InfoBanners(),
                const SizedBox(height: 20),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
