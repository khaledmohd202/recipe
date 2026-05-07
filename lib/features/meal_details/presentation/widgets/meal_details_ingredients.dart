import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/features/meal_details/data/models/ingredient_model.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';

class MealDetailsIngredients extends StatelessWidget {
  const MealDetailsIngredients({super.key, required this.meal});
  final MealDetailModel meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        ...meal.ingredients.map(
          (ingredient) => _IngredientItem(ingredient: ingredient),
        ),
      ],
    );
  }
}

class _IngredientItem extends StatelessWidget {
  const _IngredientItem({required this.ingredient});
  final IngredientModel ingredient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 13.sp,
              color: AppColors.primaryLight,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(ingredient.name, style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
