import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/app_colors.dart';
import '../../../utility/app_snackbar.dart';
import '../model/user_profile_model.dart';

class ProfileController extends GetxController {
  final Rx<UserProfileModel> user = UserProfileModel.defaultUser.obs;
  final RxBool isDarkMode = true.obs;
  final RxBool isNotificationEnabled = true.obs;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
  }

  void toggleNotifications(bool value) {
    isNotificationEnabled.value = value;
  }

  void logout() {
    Get.defaultDialog(
      title: "Log Out",
      titleStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      middleText: "Are you sure you want to log out?",
      middleTextStyle: const TextStyle(
        color: AppColors.textSecondary,
      ),
      backgroundColor: AppColors.surface,
      textConfirm: "Log Out",
      confirmTextColor: Colors.white,
      buttonColor: AppColors.error,
      textCancel: "Cancel",
      cancelTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        AppSnackbar.info(
          "Logged Out",
          "You have been successfully logged out",
        );
      },
    );
  }
}
