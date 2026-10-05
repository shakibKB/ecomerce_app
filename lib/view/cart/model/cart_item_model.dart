import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/model/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final RxInt quantity;
  final String selectedSize;
  final Color selectedColor;

  CartItemModel({
    required this.product,
    int initialQuantity = 1,
    this.selectedSize = "US 9",
    this.selectedColor = Colors.white,
  }) : quantity = initialQuantity.obs;

  double get totalPrice => product.price * quantity.value;
}
