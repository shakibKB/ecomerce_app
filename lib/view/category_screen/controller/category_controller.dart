import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/model/product_model.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString selectedCategory = "All".obs;
  final RxString searchQuery = "".obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<ProductModel> allProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    categories.assignAll(CategoryModel.defaultCategories);
    allProducts.assignAll(ProductModel.sampleProducts);
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = "";
  }

  List<ProductModel> get filteredProducts {
    return allProducts.where((product) {
      final matchesCategory = selectedCategory.value == "All" ||
          product.category.toLowerCase() ==
              selectedCategory.value.toLowerCase();
      final matchesSearch = searchQuery.value.isEmpty ||
          product.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          product.brand
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<ProductModel> get popularProducts =>
      allProducts.where((p) => p.rating >= 4.7).toList();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
