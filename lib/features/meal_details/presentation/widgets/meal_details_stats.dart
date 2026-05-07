import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';

class MealDetailsStats extends StatelessWidget {
  const MealDetailsStats({super.key, required this.meal});
  final MealDetailModel meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(icon: Icons.access_time, label: '${meal.cookedTime} mins'),
          _Divider(),
          _StatItem(icon: Icons.bar_chart, label: meal.cookingLevel),
          _Divider(),
          _StatItem(
            icon: Icons.local_fire_department,
            label: '${meal.kcal} kcal',
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 20.sp),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1.w, height: 30.h, color: Colors.grey.shade300);
  }
}
