import 'package:flutter/material.dart';
import 'dart:async';
import '../../onboarding/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFF9F9FF),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 48, left: 17, right: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 290, left: 19, right: 19),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(top: 37),
                                            margin: const EdgeInsets.only(bottom: 2),
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: const Color(0xFF00694C),
                                                    ),
                                                    padding: const EdgeInsets.all(18),
                                                    margin: const EdgeInsets.only(bottom: 15),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: 32,
                                                          height: 36,
                                                          child: Image.network(
                                                            "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/nysq57ef_expires_30_days.png",
                                                            fit: BoxFit.fill,
                                                            errorBuilder: (_, __, ___) => const Icon(
                                                              Icons.fact_check_rounded,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(bottom: 32, left: 40, right: 40),
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(bottom: 4),
                                                        child: const Text(
                                                          "HoaxCheck",
                                                          style: TextStyle(
                                                            color: Color(0xFF151C27),
                                                            fontSize: 28,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 183,
                                                        child: Text(
                                                          "Bantu Kenali Informasi yang\nMeragukan",
                                                          style: TextStyle(
                                                            color: Color(0xFF3D4A43),
                                                            fontSize: 14,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(9999),
                                                        color: const Color(0xFFE7EEFE),
                                                      ),
                                                      width: 200,
                                                      height: 4,
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(9999),
                                                          color: const Color(0xFF00694C),
                                                        ),
                                                        width: 136,
                                                        height: 4,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(9999),
                                                            color: const Color(0xFF00694C),
                                                          ),
                                                          margin: const EdgeInsets.only(right: 4),
                                                          width: 6,
                                                          height: 6,
                                                        ),
                                                        const Text(
                                                          "Sinkronisasi basis data fakta...",
                                                          style: TextStyle(
                                                            color: Color(0xFF3D4A43),
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(9999),
                                              color: const Color(0x99E7EEFE),
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 23),
                                            margin: const EdgeInsets.symmetric(horizontal: 32),
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(9999),
                                                    color: const Color(0xFFF0F3FF),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color(0x0D000000),
                                                        blurRadius: 2,
                                                        offset: Offset(0, 1),
                                                      ),
                                                    ],
                                                  ),
                                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                                  margin: const EdgeInsets.only(bottom: 4),
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: const [
                                                      Icon(
                                                        Icons.verified_user_outlined,
                                                        size: 14,
                                                        color: Color(0xFF00694C),
                                                      ),
                                                      SizedBox(width: 6),
                                                      Text(
                                                        "Didukung NLP & Verifikasi Publik",
                                                        style: TextStyle(
                                                          color: Color(0xFF3D4A43),
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Text(
                                                  "Versi 1.0.0",
                                                  style: TextStyle(
                                                    color: Color(0xFF6D7A73),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Backward compatibility alias
typedef Splashscreen = SplashPage;
