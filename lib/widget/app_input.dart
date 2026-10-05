import 'package:flutter/material.dart';
import '../utility/app_colors.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.validator,
    this.textType,
    this.onClick,
    this.onChanged,
    this.maxLine = 1,
    this.fillColor = AppColors.card,
    this.isValidatorNeed = true,
    this.circle = 12,
    this.hintColor = AppColors.textMuted,
    this.textColor = AppColors.textPrimary,
  });

  final String hint;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? textType;
  final VoidCallback? onClick;
  final Function(String)? onChanged;
  final int maxLine;
  final Color? fillColor;
  final bool isValidatorNeed;
  final double circle;
  final Color hintColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onClick,
      onChanged: onChanged,
      maxLines: maxLine,
      keyboardType: textType,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: textColor,
      ),
      readOnly: readOnly,
      obscureText: obscureText,
      controller: controller,
      cursorColor: AppColors.primary,
      validator: validator ??
          (v) {
            if (isValidatorNeed) {
              if (v == null || v.trim().isEmpty) {
                return "This field is required";
              }
              return null;
            }
            return null;
          },
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: hintColor,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
    );
  }
}
