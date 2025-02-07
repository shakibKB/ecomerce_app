
import 'package:get/get.dart';
import '../../../utility/assets.dart';

class HomeController extends GetxController{
  RxList banner = [Assets.banner1,Assets.banner2,Assets.banner3].obs;
  RxInt currentIndex = 0.obs;


  updateIndex(index){
    currentIndex.value = index;
    update();
  }
}