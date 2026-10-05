import 'package:flutter/material.dart';
import '../utility/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.name,
    required this.onClick,
    this.bgColor = AppColors.primary,
    this.textColor = Colors.white,
    this.height = 48,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderRadius = 14,
    this.icon,
  });

  final String name;
  final VoidCallback onClick;
  final Color? bgColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final bool isLoading;
  final double borderRadius;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: isLoading ? null : onClick,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
