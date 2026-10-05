import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_snackbar.dart';
import '../../widget/app_button.dart';
import '../dashboard/controller/bottom_nav_controller.dart';
import 'controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.find<CartController>();
  final TextEditingController _promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Obx(() {
          return Row(
            children: [
              const Text(
                "My Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              if (cartController.totalItemCount > 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${cartController.totalItemCount}",
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
        actions: [
          Obx(() {
            if (cartController.items.isEmpty) return const SizedBox.shrink();
            return TextButton(
              onPressed: () => cartController.clearCart(),
              child: const Text(
                "Clear",
                style: TextStyle(color: AppColors.error, fontSize: 13),
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return _buildEmptyCart();
        }

        return Column(
          children: [
            // Cart Items List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: cartController.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final item = cartController.items[index];
                  return _buildCartItemTile(item, index);
                },
              ),
            ),

            // Checkout & Order Summary Bottom Area
            _buildCheckoutSection(context),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyCart() {
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
                Icons.shopping_bag_outlined,
                size: 64,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Cart is Empty",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Looks like you haven't added any sneakers to your cart yet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              name: "Start Shopping",
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

  Widget _buildCartItemTile(dynamic item, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Image
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF262630),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              item.product.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 14),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => cartController.removeItem(index),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.error,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "Size: ${item.selectedSize}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: item.selectedColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${item.totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    // Stepper (- Qty +)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                cartController.decrementQuantity(index),
                            child: const Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${item.quantity.value}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                cartController.incrementQuantity(index),
                            child: const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Promo Code Row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: TextField(
                    controller: _promoController,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: "Enter promo code (try NIKE30)",
                      hintStyle: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onPressed: () {
                    final success =
                        cartController.applyPromoCode(_promoController.text);
                    if (success) {
                      AppSnackbar.success(
                        "Promo Applied!",
                        "You saved ${(cartController.discountPercentage.value * 100).toInt()}% off!",
                      );
                    } else {
                      AppSnackbar.error(
                        "Invalid Code",
                        "Please use valid promo code like 'NIKE30'",
                      );
                    }
                  },
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Price breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              Text("\$${cartController.subtotal.toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Delivery Fee",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              Text(
                cartController.deliveryFee == 0
                    ? "FREE"
                    : "\$${cartController.deliveryFee.toStringAsFixed(2)}",
                style: TextStyle(
                  color: cartController.deliveryFee == 0
                      ? AppColors.success
                      : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (cartController.discountAmount > 0) ...[
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount (${(cartController.discountPercentage.value * 100).toInt()}%)",
                  style: const TextStyle(color: AppColors.success, fontSize: 13),
                ),
                Text(
                  "-\$${cartController.discountAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(color: AppColors.border),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${cartController.finalTotal.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Checkout Button
          AppButton(
            name: "Proceed to Checkout",
            bgColor: AppColors.primary,
            textColor: Colors.white,
            width: double.infinity,
            onClick: () => _showCheckoutSuccessDialog(context),
          ),
        ],
      ),
    );
  }

  void _showCheckoutSuccessDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                "Order Placed Successfully! 🎉",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Thank you for your order. We've sent the invoice and tracking details to your email.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                name: "Back to Home",
                bgColor: AppColors.primary,
                textColor: Colors.white,
                width: double.infinity,
                onClick: () {
                  cartController.clearCart();
                  Navigator.pop(context);
                  Get.find<BottomNavController>().goToHome();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
