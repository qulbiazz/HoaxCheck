import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xE3FFFFFF),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 8,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 16),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicWidth(
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 32,
                      height: 32,
                      child: Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/wlomilh9_expires_30_days.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    IntrinsicWidth(
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "HoaxCheck",
                              style: TextStyle(
                                color: Color(0xFF00288E),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IntrinsicWidth(
                              child: IntrinsicHeight(
                                child: Container(
                                  padding: const EdgeInsets.only(right: 44),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Beranda",
                                        style: TextStyle(
                                          color: Color(0xFF444653),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
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
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 84,
              height: 44,
              child: Image.network(
                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/Vnf0UJfLdi/szqpq49v_expires_30_days.png",
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}