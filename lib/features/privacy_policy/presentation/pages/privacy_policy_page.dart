import 'package:flutter/material.dart';
import '../widgets/privacy_header.dart';
import '../widgets/privacy_summary_card.dart';
import '../widgets/privacy_accordion_list.dart';
import '../widgets/privacy_footer_note.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                PrivacyHeader(),
                SizedBox(height: 20),
                PrivacySummaryCard(),
                SizedBox(height: 20),
                PrivacyAccordionList(),
                SizedBox(height: 24),
                PrivacyFooterNote(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}