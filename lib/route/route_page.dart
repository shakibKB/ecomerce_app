import 'package:get/get.dart';
import '../view/cart/cart_screen.dart';
import '../view/category_screen/category_screen.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/home/home_screen.dart';
import '../view/profile/profile_screen.dart';
import '../view/wishlist/wishlist_screen.dart';
import 'route_name.dart';

class RoutePage {
  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRoute.dashboard,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: AppRoute.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoute.category,
      page: () => CategoryScreen(),
    ),
    GetPage(
      name: AppRoute.cart,
      page: () => CartScreen(),
    ),
    GetPage(
      name: AppRoute.wishlist,
      page: () => const WishlistScreen(),
    ),
    GetPage(
      name: AppRoute.profile,
      page: () => const ProfileScreen(),
    ),
  ];
}