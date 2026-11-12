import 'package:flutter/material.dart';

class ForgotPasswordFooter extends StatelessWidget {
  const ForgotPasswordFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Pusat Bantuan", style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("•", style: TextStyle(color: Color(0xFF94A3B8))),
        ),
        Text("Kebijakan Privasi", style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("•", style: TextStyle(color: Color(0xFF94A3B8))),
        ),
        Text("Hubungi Tim", style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
      ],
    );
  }
}