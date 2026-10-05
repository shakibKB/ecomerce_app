import 'package:get/get.dart';
import '../../home/controller/home_controller.dart';
import '../../home/model/product_model.dart';

class WishlistController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  List<ProductModel> get wishlistItems => homeController.wishlistProducts;

  void toggleFavorite(ProductModel product) {
    homeController.toggleFavorite(product);
  }

  void removeFromWishlist(ProductModel product) {
    product.isFavorite.value = false;
    homeController.products.refresh();
  }
}
