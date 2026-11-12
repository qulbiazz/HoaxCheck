import 'package:flutter/material.dart';
import '../../../../../app/theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isObscure;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? bottomNote;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.isObscure = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.bottomNote,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 14, color: isDark ? AppDarkColors.textPrimary : const Color(0xFF0F172A)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.5, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8)),
            prefixIcon: Icon(prefixIcon, color: isDark ? AppDarkColors.textSecondary : const Color(0xFF94A3B8), size: 20),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: isDark ? AppDarkColors.primary : const Color(0xFF006B4D), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.danger, width: 1),
            ),
          ),
          validator: validator,
        ),
        if (bottomNote != null) ...[
          const SizedBox(height: 4),
          bottomNote!,
        ]
      ],
    );
  }
}