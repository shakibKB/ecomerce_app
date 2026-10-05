import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../../widget/app_input.dart';
import '../cart/controller/cart_controller.dart';
import '../product_details/product_details_screen.dart';
import 'controller/category_controller.dart';
import 'widget/category_card.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final CategoryController categoryController = Get.find<CategoryController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Categories & Products",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: AppInput(
              prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
              hint: "Search within categories...",
              controller: categoryController.searchController,
              fillColor: AppColors.card,
              hintColor: AppColors.textMuted,
              suffixIcon: Obx(() {
                if (categoryController.searchQuery.value.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textMuted),
                    onPressed: () {
                      categoryController.clearSearch();
                    },
                  );
                }
                return const SizedBox.shrink();
              }),
              onChanged: (val) {
                categoryController.updateSearch(val);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Horizontal Category Chips
            SizedBox(
              height: 38,
              child: Obx(() {
                final selected = categoryController.selectedCategory.value;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryController.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = categoryController.categories[index];
                    final isSelected = cat.title == selected;
                    return GestureDetector(
                      onTap: () => categoryController.selectCategory(cat.title),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.card,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cat.title,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 20),

            // Most Popular Section Header
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Popular",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Top Rated ⭐",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Horizontal Most Popular Slider
            SizedBox(
              height: 190,
              child: Obx(() {
                final popular = categoryController.popularProducts;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popular.length,
                  itemBuilder: (context, index) {
                    final product = popular[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CategoryCard(
                        name: product.name,
                        brand: product.brand,
                        price: product.price.toStringAsFixed(0),
                        image: product.image,
                        rating: product.rating,
                        onClick: () => Get.to(
                          () => ProductDetailsScreen(
                            product: product,
                            heroTag: "category_popular_${product.id}",
                          ),
                        ),
                        onAddToCart: () => cartController.addToCart(product),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 24),

            // Category Products Grid Header
            Obx(() {
              final cat = categoryController.selectedCategory.value;
              return Text(
                cat == "All" ? "All Products" : "$cat Collection",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }),
            const SizedBox(height: 12),

            // Grid of Products
            Obx(() {
              final products = categoryController.filteredProducts;

              if (products.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(40),
                  alignment: Alignment.center,
                  child: const Column(
                    children: [
                      Icon(Icons.inbox_outlined,
                          size: 48, color: AppColors.textMuted),
                      SizedBox(height: 8),
                      Text(
                        "No products in this category",
                        style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 14),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CategoryCard(
                    image: product.image,
                    name: product.name,
                    brand: product.brand,
                    price: product.price.toStringAsFixed(0),
                    rating: product.rating,
                    onClick: () => Get.to(
                      () => ProductDetailsScreen(
                        product: product,
                        heroTag: "category_grid_${product.id}",
                      ),
                    ),
                    onAddToCart: () => cartController.addToCart(product),
                  );
                },
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
