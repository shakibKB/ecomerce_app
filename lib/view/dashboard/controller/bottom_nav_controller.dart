import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void goToHome() => currentIndex.value = 0;
  void goToCategory() => currentIndex.value = 1;
  void goToCart() => currentIndex.value = 2;
  void goToWishlist() => currentIndex.value = 3;
  void goToProfile() => currentIndex.value = 4;
}
