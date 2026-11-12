import 'package:flutter/material.dart';

class OnboardingNavigation extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final Color primaryColor;
  final VoidCallback onNext;

  const OnboardingNavigation({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    required this.primaryColor,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentIndex == totalPages - 1;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
       child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLastPage ? 'Mulai' : 'Berikutnya',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            // Ubah bagian ini: Gunakan Icons.arrow_forward_rounded untuk semua halaman
            const Icon(
              Icons.arrow_forward_rounded,
              size: 20,
              color: Colors.white, 
            ),
          ],
        ),
      ),
    );
  }
}