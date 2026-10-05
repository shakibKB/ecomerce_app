import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/app_colors.dart';
import '../../cart/controller/cart_controller.dart';
import '../../home/controller/home_controller.dart';
import '../controller/bottom_nav_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController navController = Get.find<BottomNavController>();
    final CartController cartController = Get.find<CartController>();
    final HomeController homeController = Get.find<HomeController>();

    return Obx(() {
      final selectedIndex = navController.currentIndex.value;
      final cartCount = cartController.totalItemCount;
      final wishlistCount = homeController.wishlistProducts.length;

      return Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
          border: const Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  isSelected: selectedIndex == 0,
                  label: "Home",
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  onTap: () => navController.changeIndex(0),
                ),
                _buildNavItem(
                  index: 1,
                  isSelected: selectedIndex == 1,
                  label: "Categories",
                  icon: Icons.grid_view_outlined,
                  activeIcon: Icons.grid_view_rounded,
                  onTap: () => navController.changeIndex(1),
                ),
                _buildNavItem(
                  index: 2,
                  isSelected: selectedIndex == 2,
                  label: "Cart",
                  icon: Icons.shopping_bag_outlined,
                  activeIcon: Icons.shopping_bag_rounded,
                  badgeCount: cartCount,
                  onTap: () => navController.changeIndex(2),
                ),
                _buildNavItem(
                  index: 3,
                  isSelected: selectedIndex == 3,
                  label: "Wishlist",
                  icon: Icons.favorite_border_rounded,
                  activeIcon: Icons.favorite_rounded,
                  badgeCount: wishlistCount,
                  onTap: () => navController.changeIndex(3),
                ),
                _buildNavItem(
                  index: 4,
                  isSelected: selectedIndex == 4,
                  label: "Profile",
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  onTap: () => navController.changeIndex(4),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required int index,
    required bool isSelected,
    required String label,
    required IconData icon,
    required IconData activeIcon,
    required VoidCallback onTap,
    int badgeCount = 0,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  size: 24,
                  color: isSelected ? AppColors.primary : AppColors.textMuted,
                ),
                if (badgeCount > 0)
                  Positioned(
                    top: -5,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.surface,
                          width: 1.5,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        badgeCount > 99 ? "99+" : badgeCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
