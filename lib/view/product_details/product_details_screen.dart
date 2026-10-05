import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../../widget/app_button.dart';
import '../home/model/product_model.dart';
import 'controller/product_details_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  final String? heroTag;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final ProductDetailsController controller = Get.put(
      ProductDetailsController(product: product),
      tag: product.id,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          product.brand,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            final isFav = product.isFavorite.value;
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFav ? AppColors.primary : Colors.white,
              ),
              onPressed: () => controller.toggleFavorite(),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Hero Image Card
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                gradient: const RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    Color(0xFF2E2E38),
                    Color(0xFF141418),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: heroTag ?? "product_${product.id}",
                      child: Image.asset(
                        product.image,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  if (product.oldPrice != null)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${(((product.oldPrice! - product.price) / product.oldPrice!) * 100).round()}% OFF",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Title & Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: AppColors.star, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            "${product.rating}",
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "(${product.reviewCount} Reviews)",
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${product.price.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    if (product.oldPrice != null)
                      Text(
                        "\$${product.oldPrice!.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Select Size Section
            const Text(
              "Select Size",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: Obx(() {
                final currentSize = controller.selectedSize.value;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.sizes.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final size = product.sizes[index];
                    final isSelected = size == currentSize;
                    return GestureDetector(
                      onTap: () => controller.selectSize(size),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.card,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          size,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 24),

            // Select Color Section
            const Text(
              "Color",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              final activeColor = controller.selectedColor.value;
              return Row(
                children: product.colors.map((color) {
                  final isSelected = color == activeColor;
                  return GestureDetector(
                    onTap: () => controller.selectColor(color),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: color,
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                size: 14,
                                color: color == Colors.white
                                    ? Colors.black
                                    : Colors.white,
                              )
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 24),

            // Description
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(
            top: BorderSide(color: AppColors.border),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  name: "Add to Cart",
                  bgColor: AppColors.card,
                  textColor: AppColors.textPrimary,
                  onClick: () => controller.addToCart(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  name: "Buy Now",
                  bgColor: AppColors.primary,
                  textColor: Colors.white,
                  onClick: () => controller.buyNow(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
