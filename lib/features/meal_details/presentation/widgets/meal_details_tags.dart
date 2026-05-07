import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';

class MealDetailsTags extends StatelessWidget {
  const MealDetailsTags({super.key, required this.meal});
  final MealDetailModel meal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Tag(
          label: meal.country,
          backgroundColor: AppColors.primaryLight.withValues(alpha: 0.1),
          textColor: AppColors.primaryLight,
        ),
        SizedBox(width: 8.w),
        _Tag(
          label: meal.mealSection.toUpperCase(),
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black54,
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        // border: Border.all(color: backgroundColor),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
