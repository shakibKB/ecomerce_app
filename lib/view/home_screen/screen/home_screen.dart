import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/view/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../route/route_name.dart';
import '../../../utility/assets.dart';
import '../../../widget/app_button.dart';
import '../../category_screen/widget/category_card.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:const Text("Category Screen ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.brown),),
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        // bottom:PreferredSize(
        //     preferredSize:const Size.square(60),
        //     child: Padding(
        //       padding: const EdgeInsets.only(left: 20.0,right: 20),
        //       child: AppInput(prefixIcon:const Icon(Icons.search),hint: "search", controller: _search),
        //     )) ,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            const SizedBox(height: 15,),
            //banner
            SizedBox(
              height: 150,
              child: CarouselSlider(
                items: controller.banner.map((imageUrl){
                  return Builder(builder: (BuildContext context){
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(imageUrl,fit: BoxFit.cover,width: double.infinity,));
                  });
                }).toList(),
                options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    onPageChanged: (index,reason){
                      controller.updateIndex(index);
                    }
                ),
              ),
            ),

            const SizedBox(height: 20,),

            //new ARRIVALS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("NEW ARRIVALS",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                AppButton(name: "View All", onClick: ()=>Get.toNamed(AppRoute.categoryScreen),height: 25,width: 100,bgColor: Colors.grey,),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryCard(
                          name: "Nike",
                          rating: 4.5,
                          price: "2100",
                          onClick: ()=>Get.toNamed(AppRoute.singleProduct),
                          image: Assets.nike),
                    );

                  }),

            ),
            const SizedBox(height: 15,),

           // most popular
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Most Popular",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                AppButton(name: "View All", onClick: ()=>Get.toNamed(AppRoute.categoryScreen),height: 25,width: 100,bgColor: Colors.grey,),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 180,
              child: ListView.builder(

                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryCard(
                          name: "Nike",
                          rating: 4.5,
                          price: "2100",
                          onClick: (){},
                          image: Assets.nike),
                    );

                  }),

            ),


            // const SizedBox(height: 15,),
            // //all Collection
            // const  Text("All Category",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),),
            // SizedBox(
            //   height: MediaQuery.sizeOf(context).height*.83,
            //   child: GridView.builder(
            //       shrinkWrap: true,
            //       physics:const NeverScrollableScrollPhysics(),
            //       itemCount: 10,
            //       gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           mainAxisSpacing: 10,
            //           crossAxisSpacing: 10,
            //           childAspectRatio: .90,
            //           mainAxisExtent: 180
            //       ),
            //       itemBuilder: (context,index){
            //         return CategoryCard(
            //           image:Assets.nike,
            //           name: "Nike",
            //           price: "1500",
            //           onClick: (){},
            //         );
            //
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
