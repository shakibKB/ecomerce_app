import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

class AppSnackbar {
  static void show({
    required String title,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Color? iconColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    final context = Get.context;
    if (context == null) return;

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? AppColors.surface,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor ?? AppColors.primary, size: 22),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor ?? AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (message.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void success(String title, String message) {
    show(
      title: title,
      message: message,
      icon: Icons.check_circle_rounded,
      iconColor: AppColors.success,
    );
  }

  static void error(String title, String message) {
    show(
      title: title,
      message: message,
      icon: Icons.error_outline_rounded,
      iconColor: AppColors.error,
    );
  }

  static void info(String title, String message) {
    show(
      title: title,
      message: message,
      icon: Icons.info_outline_rounded,
      iconColor: AppColors.primary,
    );
  }
}
