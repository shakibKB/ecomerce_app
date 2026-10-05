import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../../widget/app_input.dart';
import '../dashboard/controller/bottom_nav_controller.dart';
import 'controller/home_controller.dart';
import 'widget/banner_slider.dart';
import 'widget/category_chip_list.dart';
import 'widget/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top App Bar / Profile Header
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.card,
                          child: Icon(
                            Icons.person_rounded,
                            color: AppColors.primary,
                            size: 26,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back 👋",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Sneaker Store",
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Notification Icon with Badge
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: AppInput(
                        hint: "Search sneakers, brands...",
                        controller: _searchController,
                        fillColor: AppColors.card,
                        hintColor: AppColors.textMuted,
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.textMuted,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear,
                                    color: AppColors.textMuted),
                                onPressed: () {
                                  _searchController.clear();
                                  homeController.updateSearch("");
                                },
                              )
                            : null,
                        onChanged: (val) {
                          homeController.updateSearch(val);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune_rounded,
                            color: Colors.white),
                        onPressed: () {
                          // Jump to categories tab for detailed filtering
                          bottomNavController.goToCategory();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Promotional Banner
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: BannerSlider(),
              ),
            ),

            // Categories horizontal bar
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CategoryChipList(),
              ),
            ),

            // Section Header: Popular Products
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular Sneakers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => bottomNavController.goToCategory(),
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Product Grid
            Obx(() {
              final list = homeController.filteredProducts;

              if (list.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: AppColors.textMuted,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "No sneakers found",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.68,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductCard(
                        product: list[index],
                        heroTag: "home_product_${list[index].id}",
                      );
                    },
                    childCount: list.length,
                  ),
                ),
              );
            }),

            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }
}
