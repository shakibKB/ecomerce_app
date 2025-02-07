import 'package:ecom/view/cart_screen/screen/cart_screen.dart';
import 'package:ecom/view/category_screen/screen/category_screen.dart';
import 'package:ecom/view/favorite_screen/screen/favorite_screen.dart';
import 'package:ecom/view/home_screen/screen/home_screen.dart';
import 'package:ecom/view/profile_screen/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController{



  List pagesList =[HomeScreen(),CategoryScreen(),CartScreen(),FavoriteScreen(),ProfileScreen()];

  var currentIndex =0.obs;

  void changeIndex(v){
    currentIndex.value = v;
  }

}