import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../app/theme.dart';

import '../widgets/detection_header.dart';
import '../widgets/clipboard_banner.dart';
import '../widgets/detection_input_card.dart';
import '../widgets/info_banners.dart';
import '../widgets/literacy_tips_card.dart';

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
    
    if (clipboardData != null && clipboardData.text != null && clipboardData.text!.trim().isNotEmpty) {
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DetectionHeader(),
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
                const SizedBox(height: 20),
                
                const InfoBanners(),
                const SizedBox(height: 20),
                
                const LiteracyTipsCard(),
                
                const SizedBox(height: 100), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}