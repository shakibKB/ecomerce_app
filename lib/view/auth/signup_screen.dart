import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../../widget/app_button.dart';
import '../../widget/app_input.dart';
import 'controller/auth_controller.dart';
import 'widget/social_login_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Join the sneakerhead community today",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),

              // Full Name Field
              const Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              AppInput(
                hint: "Alex Mercer",
                controller: authController.signUpNameController,
                prefixIcon: const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),

              // Email Address Field
              const Text(
                "Email Address",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              AppInput(
                hint: "alex.mercer@example.com",
                controller: authController.signUpEmailController,
                textType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              const Text(
                "Phone Number (Optional)",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              AppInput(
                hint: "+1 555-019-2834",
                controller: authController.signUpPhoneController,
                textType: TextInputType.phone,
                isValidatorNeed: false,
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return AppInput(
                  hint: "At least 6 characters",
                  controller: authController.signUpPasswordController,
                  obscureText: authController.isSignUpPasswordHidden.value,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      authController.isSignUpPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () => authController.toggleSignUpPassword(),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Confirm Password Field
              const Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return AppInput(
                  hint: "Repeat your password",
                  controller: authController.signUpConfirmPasswordController,
                  obscureText: authController.isSignUpConfirmHidden.value,
                  prefixIcon: const Icon(
                    Icons.lock_reset_rounded,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      authController.isSignUpConfirmHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () =>
                        authController.toggleSignUpConfirmPassword(),
                  ),
                );
              }),
              const SizedBox(height: 14),

              // Terms & Conditions Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: authController.agreeToTerms.value,
                        activeColor: AppColors.primary,
                        checkColor: Colors.white,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (val) =>
                            authController.toggleAgreeToTerms(val),
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: "I agree to the ",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),

              // Create Account Button
              Obx(() {
                return AppButton(
                  name: "Create Account",
                  isLoading: authController.isLoading.value,
                  onClick: () => authController.signUp(),
                );
              }),
              const SizedBox(height: 20),

              // Divider "Or sign up with"
              const Row(
                children: [
                  Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Or sign up with",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.border)),
                ],
              ),
              const SizedBox(height: 20),

              // Social Sign-up Buttons
              Row(
                children: [
                  SocialLoginButton(
                    label: "Google",
                    icon: const Text(
                      "G",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    onTap: () => authController.loginWithGoogle(),
                  ),
                  const SizedBox(width: 14),
                  SocialLoginButton(
                    label: "Apple",
                    icon: const Icon(
                      Icons.apple,
                      color: Colors.white,
                      size: 24,
                    ),
                    onTap: () => authController.loginWithApple(),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Footer: Already have an account? Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
