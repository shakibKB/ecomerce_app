import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../cart/cart_screen.dart';
import '../category_screen/category_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'controller/bottom_nav_controller.dart';
import 'widget/custom_bottom_nav_bar.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final BottomNavController navController = Get.find<BottomNavController>();

  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    const WishlistScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        return IndexedStack(
          index: navController.currentIndex.value,
          children: _screens,
        );
      }),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
