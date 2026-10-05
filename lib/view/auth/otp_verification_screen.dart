import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../../widget/app_button.dart';
import 'controller/auth_controller.dart';
import 'widget/otp_input_field.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final String email = authController.forgotEmailController.text.isNotEmpty
        ? authController.forgotEmailController.text
        : "your email";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Mail Icon Card
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    color: AppColors.primary,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              const Text(
                "OTP Verification ✉️",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Enter the 4-digit verification code sent to\n",
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // 4-Digit OTP Box Field
              OtpInputField(
                length: 4,
                onChanged: (code) {
                  authController.otpCode.value = code;
                },
                onCompleted: (code) {
                  authController.verifyOtp(code);
                },
              ),
              const SizedBox(height: 32),

              // Resend Code Countdown Timer
              Obx(() {
                final seconds = authController.resendSeconds.value;
                final canResend = authController.canResendOtp.value;

                if (canResend) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the code? ",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => authController.resendOtp(),
                        child: const Text(
                          "Resend Code",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Text(
                  "Resend code in 00:${seconds < 10 ? '0$seconds' : seconds}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                );
              }),
              const SizedBox(height: 36),

              // Verify & Proceed Button
              Obx(() {
                return AppButton(
                  name: "Verify & Proceed",
                  isLoading: authController.isLoading.value,
                  onClick: () =>
                      authController.verifyOtp(authController.otpCode.value),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
