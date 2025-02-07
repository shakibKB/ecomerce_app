import 'package:ecom/route/route_name.dart';
import 'package:ecom/utility/app_color.dart';
import 'package:ecom/widget/app_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/assets.dart';
import '../widget/category_card.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key});

  final _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: ()=>Get.back(),
            icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: AppColors.bgColor,

        title:const Text("Category Product",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),

        bottom: PreferredSize(
          preferredSize:const Size.square(50),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
            child: AppInput(
              prefixIcon: const Icon(Icons.search,),
                hint: "search", controller: _search),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding:const EdgeInsets.all(20),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("All Product ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: AppColors.textWhite),),
             const SizedBox(height: 20,),
              Expanded(
                child: GridView.builder(
                    itemCount: 10,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: .90,
                        mainAxisExtent: 180
                    ),
                    itemBuilder: (context,index){
                      return CategoryCard(
                        image:Assets.nike,
                        name: "Nike",
                        price: "1500",
                        rating: 3.5,
                        onClick: ()=>Get.toNamed(AppRoute.singleProduct),
                      );

                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
