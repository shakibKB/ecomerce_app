import 'package:ecom/utility/app_color.dart';
import 'package:ecom/view/app_bottom_navbar/controller/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppBottomNavbar extends StatelessWidget {
   AppBottomNavbar({super.key});
   final NavController controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(()=>controller.pagesList[controller.currentIndex.value]),
      
      bottomNavigationBar: Obx((){
          return BottomNavigationBar(
            backgroundColor: AppColors.bgColor,
            currentIndex: controller.currentIndex.value,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: controller.changeIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.dashboard,),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.manage_search),label: "All Product"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined),label: "Cart"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "Favorite"),
                BottomNavigationBarItem(icon: Icon(Icons.perm_identity),label: "setting"),
              ],
          );
        }
      ),
    );
  }
}
