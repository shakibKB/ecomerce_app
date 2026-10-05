import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'route/route_name.dart';
import 'route/route_page.dart';
import 'utility/app_colors.dart';
import 'view/auth/controller/auth_controller.dart';
import 'view/cart/controller/cart_controller.dart';
import 'view/category_screen/controller/category_controller.dart';
import 'view/dashboard/controller/bottom_nav_controller.dart';
import 'view/home/controller/home_controller.dart';
import 'view/profile/controller/profile_controller.dart';
import 'view/wishlist/controller/wishlist_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Feature MVP Controllers
  Get.put(AuthController());
  Get.put(BottomNavController());
  Get.put(HomeController());
  Get.put(CategoryController());
  Get.put(CartController());
  Get.put(WishlistController());
  Get.put(ProfileController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Sneaker Ecommerce",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      initialRoute: AppRoute.dashboard,
      getPages: RoutePage.routes,
    );
  }
}
