import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../../widget/app_button.dart';
import '../dashboard/controller/bottom_nav_controller.dart';
import '../home/widget/product_card.dart';
import 'controller/wishlist_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find<WishlistController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Obx(() {
          final count = wishlistController.wishlistItems.length;
          return Row(
            children: [
              const Text(
                "My Wishlist",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              if (count > 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$count",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
      body: Obx(() {
        final wishlist = wishlistController.wishlistItems;

        if (wishlist.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      size: 64,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your Wishlist is Empty",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Save items you like and they will appear here.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    name: "Discover Sneakers",
                    bgColor: AppColors.primary,
                    textColor: Colors.white,
                    width: 200,
                    onClick: () {
                      Get.find<BottomNavController>().goToHome();
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          itemCount: wishlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              product: wishlist[index],
              heroTag: "wishlist_product_${wishlist[index].id}",
            );
          },
        );
      }),
    );
  }
}
