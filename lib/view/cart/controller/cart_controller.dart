import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/app_snackbar.dart';
import '../../home/model/product_model.dart';
import '../model/cart_item_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final RxString appliedPromoCode = "".obs;
  final RxDouble discountPercentage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    if (ProductModel.sampleProducts.isNotEmpty) {
      items.add(
        CartItemModel(
          product: ProductModel.sampleProducts[0],
          initialQuantity: 1,
          selectedSize: "US 9",
          selectedColor: Colors.white,
        ),
      );
    }
  }

  int get totalItemCount {
    return items.fold(0, (sum, item) => sum + item.quantity.value);
  }

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee {
    if (subtotal == 0 || subtotal >= 200) return 0.0;
    return 15.0;
  }

  double get discountAmount {
    return subtotal * discountPercentage.value;
  }

  double get finalTotal {
    final total = subtotal - discountAmount + deliveryFee;
    return total > 0 ? total : 0;
  }

  void addToCart(
    ProductModel product, {
    String size = "US 9",
    Color color = Colors.white,
  }) {
    final existingIndex = items.indexWhere(
      (item) => item.product.id == product.id && item.selectedSize == size,
    );

    if (existingIndex != -1) {
      items[existingIndex].quantity.value++;
    } else {
      items.add(
        CartItemModel(
          product: product,
          initialQuantity: 1,
          selectedSize: size,
          selectedColor: color,
        ),
      );
    }
    items.refresh();

    AppSnackbar.success(
      "Added to Cart",
      "${product.name} has been added to your cart",
    );
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < items.length) {
      items[index].quantity.value++;
      items.refresh();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < items.length) {
      if (items[index].quantity.value > 1) {
        items[index].quantity.value--;
        items.refresh();
      } else {
        removeItem(index);
      }
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      final removed = items.removeAt(index);
      items.refresh();
      AppSnackbar.info(
        "Removed",
        "${removed.product.name} removed from cart",
      );
    }
  }

  bool applyPromoCode(String code) {
    final clean = code.trim().toUpperCase();
    if (clean == "NIKE30" || clean == "SAVE30") {
      appliedPromoCode.value = clean;
      discountPercentage.value = 0.30;
      return true;
    } else if (clean == "WELCOME" || clean == "SAVE10") {
      appliedPromoCode.value = clean;
      discountPercentage.value = 0.10;
      return true;
    }
    return false;
  }

  void removePromo() {
    appliedPromoCode.value = "";
    discountPercentage.value = 0.0;
  }

  void clearCart() {
    items.clear();
    removePromo();
  }
}
