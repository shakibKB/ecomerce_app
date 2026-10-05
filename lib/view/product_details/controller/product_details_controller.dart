import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';
import '../../dashboard/controller/bottom_nav_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../home/model/product_model.dart';

class ProductDetailsController extends GetxController {
  final ProductModel product;

  ProductDetailsController({required this.product});

  late RxString selectedSize;
  late Rx<Color> selectedColor;

  final CartController cartController = Get.find<CartController>();
  final HomeController homeController = Get.find<HomeController>();
  final BottomNavController navController = Get.find<BottomNavController>();

  @override
  void onInit() {
    super.onInit();
    selectedSize = (product.sizes.isNotEmpty ? product.sizes[0] : "US 9").obs;
    selectedColor = (product.colors.isNotEmpty ? product.colors[0] : Colors.white).obs;
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectColor(Color color) {
    selectedColor.value = color;
  }

  void toggleFavorite() {
    homeController.toggleFavorite(product);
  }

  void addToCart() {
    cartController.addToCart(
      product,
      size: selectedSize.value,
      color: selectedColor.value,
    );
  }

  void buyNow() {
    addToCart();
    Get.back();
    navController.goToCart();
  }
}
