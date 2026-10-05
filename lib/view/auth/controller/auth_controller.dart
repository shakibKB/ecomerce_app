import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../route/route_name.dart';
import '../../../utility/app_snackbar.dart';
import '../model/user_model.dart';

class AuthController extends GetxController {
  // Loading State
  final RxBool isLoading = false.obs;

  // Current Logged-in User
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  // --- Login Form ---
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final RxBool isLoginPasswordHidden = true.obs;
  final RxBool rememberMe = true.obs;

  // --- Sign Up Form ---
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPhoneController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  final RxBool isSignUpPasswordHidden = true.obs;
  final RxBool isSignUpConfirmHidden = true.obs;
  final RxBool agreeToTerms = false.obs;

  // --- Forgot Password & OTP ---
  final TextEditingController forgotEmailController = TextEditingController();
  final RxString otpCode = "".obs;
  final RxInt resendSeconds = 60.obs;
  final RxBool canResendOtp = false.obs;
  Timer? _resendTimer;

  // --- Reset Password Form ---
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final RxBool isNewPasswordHidden = true.obs;
  final RxBool isConfirmNewPasswordHidden = true.obs;

  // Toggle Visibility
  void toggleLoginPassword() =>
      isLoginPasswordHidden.value = !isLoginPasswordHidden.value;
  void toggleSignUpPassword() =>
      isSignUpPasswordHidden.value = !isSignUpPasswordHidden.value;
  void toggleSignUpConfirmPassword() =>
      isSignUpConfirmHidden.value = !isSignUpConfirmHidden.value;
  void toggleNewPassword() =>
      isNewPasswordHidden.value = !isNewPasswordHidden.value;
  void toggleConfirmNewPassword() =>
      isConfirmNewPasswordHidden.value = !isConfirmNewPasswordHidden.value;
  void toggleRememberMe(bool? val) => rememberMe.value = val ?? false;
  void toggleAgreeToTerms(bool? val) => agreeToTerms.value = val ?? false;

  // --- Login Action ---
  Future<void> login() async {
    final email = loginEmailController.text.trim();
    final password = loginPasswordController.text;

    if (email.isEmpty) {
      AppSnackbar.error("Email Required", "Please enter your email address");
      return;
    }
    if (!GetUtils.isEmail(email)) {
      AppSnackbar.error("Invalid Email", "Please enter a valid email address");
      return;
    }
    if (password.isEmpty) {
      AppSnackbar.error("Password Required", "Please enter your password");
      return;
    }
    if (password.length < 6) {
      AppSnackbar.error("Password Too Short", "Password must be at least 6 characters");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1200));
    isLoading.value = false;

    currentUser.value = UserModel(
      id: "u_101",
      name: "Alex Mercer",
      email: email,
      phone: "+1 555-019-2834",
      token: "jwt_token_sample_12345",
    );

    AppSnackbar.success("Welcome Back!", "Logged in successfully as Alex Mercer");
    Get.offAllNamed(AppRoute.dashboard);
  }

  // --- Sign Up Action ---
  Future<void> signUp() async {
    final name = signUpNameController.text.trim();
    final email = signUpEmailController.text.trim();
    final phone = signUpPhoneController.text.trim();
    final password = signUpPasswordController.text;
    final confirmPassword = signUpConfirmPasswordController.text;

    if (name.isEmpty) {
      AppSnackbar.error("Name Required", "Please enter your full name");
      return;
    }
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      AppSnackbar.error("Invalid Email", "Please enter a valid email address");
      return;
    }
    if (password.length < 6) {
      AppSnackbar.error("Weak Password", "Password must be at least 6 characters");
      return;
    }
    if (password != confirmPassword) {
      AppSnackbar.error("Mismatch", "Passwords do not match");
      return;
    }
    if (!agreeToTerms.value) {
      AppSnackbar.error("Terms Required", "Please agree to Terms & Conditions");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1200));
    isLoading.value = false;

    currentUser.value = UserModel(
      id: "u_102",
      name: name,
      email: email,
      phone: phone.isNotEmpty ? phone : "+1 555-019-2834",
    );

    AppSnackbar.success("Account Created!", "Welcome to Sneaker Store, $name");
    Get.offAllNamed(AppRoute.dashboard);
  }

  // --- Send Forgot Password Code ---
  Future<void> sendForgotPasswordOtp() async {
    final email = forgotEmailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      AppSnackbar.error("Invalid Email", "Please enter your registered email");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;

    startResendTimer();
    AppSnackbar.info("OTP Sent!", "A 4-digit code was sent to $email");
    Get.toNamed(AppRoute.otpVerification);
  }

  // --- Timer for OTP Resend ---
  void startResendTimer() {
    _resendTimer?.cancel();
    resendSeconds.value = 60;
    canResendOtp.value = false;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

  // --- Resend OTP ---
  Future<void> resendOtp() async {
    if (!canResendOtp.value) return;

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;

    startResendTimer();
    AppSnackbar.info("Code Resent", "A new 4-digit code has been sent");
  }

  // --- Verify OTP ---
  Future<void> verifyOtp(String code) async {
    otpCode.value = code;

    if (code.length < 4) {
      AppSnackbar.error("Invalid Code", "Please enter the complete 4-digit code");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;

    AppSnackbar.success("Verified!", "Code verified successfully");
    Get.toNamed(AppRoute.resetPassword);
  }

  // --- Reset Password Action ---
  Future<void> resetPassword() async {
    final newPass = newPasswordController.text;
    final confirmPass = confirmNewPasswordController.text;

    if (newPass.length < 6) {
      AppSnackbar.error("Weak Password", "Password must be at least 6 characters");
      return;
    }
    if (newPass != confirmPass) {
      AppSnackbar.error("Mismatch", "Passwords do not match");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1200));
    isLoading.value = false;

    AppSnackbar.success("Password Updated!", "Please sign in with your new password");
    // Clear forms
    newPasswordController.clear();
    confirmNewPasswordController.clear();
    forgotEmailController.clear();

    Get.offAllNamed(AppRoute.login);
  }

  // Social Login Mock
  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;

    currentUser.value = const UserModel(
      id: "u_google_1",
      name: "Alex Mercer",
      email: "alex.mercer@gmail.com",
      phone: "+1 555-019-2834",
    );

    AppSnackbar.success("Google Sign-In", "Signed in with Google successfully");
    Get.offAllNamed(AppRoute.dashboard);
  }

  Future<void> loginWithApple() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;

    currentUser.value = const UserModel(
      id: "u_apple_1",
      name: "Alex Mercer",
      email: "alex.apple@icloud.com",
      phone: "+1 555-019-2834",
    );

    AppSnackbar.success("Apple Sign-In", "Signed in with Apple successfully");
    Get.offAllNamed(AppRoute.dashboard);
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signUpNameController.dispose();
    signUpEmailController.dispose();
    signUpPhoneController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    forgotEmailController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
