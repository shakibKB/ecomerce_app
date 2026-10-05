import 'package:get/get.dart';
import '../model/product_model.dart';

class HomeController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxString selectedCategory = "All".obs;
  final RxString searchQuery = "".obs;

  final List<String> categories = const [
    "All",
    "Sneakers",
    "Running",
    "Basketball",
    "Casual",
  ];

  @override
  void onInit() {
    super.onInit();
    products.assignAll(ProductModel.sampleProducts);
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void toggleFavorite(ProductModel product) {
    product.isFavorite.value = !product.isFavorite.value;
    products.refresh();
  }

  List<ProductModel> get filteredProducts {
    return products.where((product) {
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
      products.where((p) => p.rating >= 4.7).toList();

  List<ProductModel> get wishlistProducts =>
      products.where((p) => p.isFavorite.value).toList();
}
