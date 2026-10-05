import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/app_colors.dart';
import '../../cart/controller/cart_controller.dart';
import '../../product_details/product_details_screen.dart';
import '../controller/home_controller.dart';
import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final String? heroTag;

  const ProductCard({
    super.key,
    required this.product,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final CartController cartController = Get.find<CartController>();
    final String effectiveHeroTag = heroTag ?? "product_${product.id}";

    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailsScreen(
          product: product,
          heroTag: effectiveHeroTag,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Area with Favorite & Discount Badge
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFF24242C),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF282832),
                          AppColors.card,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Hero(
                        tag: effectiveHeroTag,
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Obx(() {
                      final isFav = product.isFavorite.value;
                      return GestureDetector(
                        onTap: () =>
                            homeController.toggleFavorite(product),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 16,
                            color: isFav ? AppColors.primary : Colors.white,
                          ),
                        ),
                      );
                    }),
                  ),
                  // Discount Tag
                  if (product.oldPrice != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "${(((product.oldPrice! - product.price) / product.oldPrice!) * 100).round()}% OFF",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Product Details Area
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.star, size: 14),
                      const SizedBox(width: 3),
                      Text(
                        "${product.rating}",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${product.price.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (product.oldPrice != null)
                            Text(
                              "\$${product.oldPrice!.toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textMuted,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      // Add to Cart Button
                      GestureDetector(
                        onTap: () => cartController.addToCart(product),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
