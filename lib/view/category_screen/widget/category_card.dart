
import 'package:ecom/utility/app_color.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key, required this.name, required this.price, required this.onClick, required this.image, this.rating,
  });

  final String name;
  final String price;
  final VoidCallback onClick;
  final String image;
  final double height=200;
  final double width= 150;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height:height ,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
            border: Border.all(color: Colors.grey.shade900)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                  color: Colors.brown,
              ),
              child: Center(
                child: Image.asset(image,height: 100,width: double.infinity,fit: BoxFit.cover,),
              ) ,
            ),
            const SizedBox(height: 8,),
             Padding(
              padding: const EdgeInsets.only(left: 10),
              child:  Row(
                children: [
                  Text(name,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color:AppColors.textWhite),),
                  const SizedBox(width: 6,),
                  rating ==null ?const Center():Row(
                    children: [
                     const Icon(Icons.star,color: Colors.amber,size: 15,),

                      Text("$rating",style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: AppColors.textWhite),)
                    ],),
                ],
              ),
            ),
            const SizedBox(height: 5,),
             Padding(
              padding: const EdgeInsets.only(left: 10),
              child:  Text("\$ $price",style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.orangeAccent),),
            ),

          ],
        ),
      ),
    );
  }
}