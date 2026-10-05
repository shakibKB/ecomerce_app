import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/app_colors.dart';
import '../controller/home_controller.dart';

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return SizedBox(
      height: 40,
      child: Obx(() {
        final selected = controller.selectedCategory.value;
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final isSelected = category == selected;

            return GestureDetector(
              onTap: () => controller.selectCategory(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
