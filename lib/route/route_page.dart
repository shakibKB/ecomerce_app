import 'package:ecom/data/binding/home_binding.dart';
import 'package:ecom/route/route_name.dart';
import 'package:ecom/view/app_bottom_navbar/screen/app_bottom_navbar.dart';
import 'package:ecom/view/category_screen/screen/category_screen.dart';
import 'package:ecom/view/category_screen/screen/category_screen.dart';
import 'package:ecom/view/home_screen/screen/home_screen.dart';
import 'package:ecom/view/home_screen/screen/single_product.dart';
import 'package:get/get.dart';

class RoutePage{
  static List<GetPage<dynamic>> routes=[
    GetPage(
        name: AppRoute.homeScreen,
        page: ()=> HomeScreen(),
      binding: HomeBinding(),
    ),

    GetPage(
        name: AppRoute.singleProduct,
        page: ()=>SingleProduct()
    ),
    GetPage(
        name: AppRoute.categoryScreen,
        page: ()=>CategoryScreen(),
    ),

    GetPage(
      name: AppRoute.navScreen,
      binding: HomeBinding(),
      page: ()=>AppBottomNavbar(),
    ),
  ];
}