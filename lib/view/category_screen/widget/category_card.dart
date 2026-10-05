import 'package:flutter/material.dart';
import '../../../utility/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.name,
    required this.price,
    required this.onClick,
    required this.image,
    this.brand = "Nike",
    this.rating,
    this.onAddToCart,
  });

  final String name;
  final String price;
  final VoidCallback onClick;
  final String image;
  final String brand;
  final double? rating;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Container with Brown/Accent Gradient Header
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3D271D),
                      Color(0xFF1E1714),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Card Body Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    brand.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ $price",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.accent,
                        ),
                      ),
                      if (onAddToCart != null)
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              size: 14,
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