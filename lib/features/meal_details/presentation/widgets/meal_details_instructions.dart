import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/features/meal_details/data/models/instruction_model.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';

class MealDetailsInstructions extends StatelessWidget {
  const MealDetailsInstructions({super.key, required this.meal});
  final MealDetailModel meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        ...meal.instructions.asMap().entries.map(
          (entry) => _InstructionItem(
            stepNumber: entry.key + 1,
            instruction: entry.value,
          ),
        ),
      ],
    );
  }
}


class _InstructionItem extends StatelessWidget {
  const _InstructionItem({required this.stepNumber, required this.instruction});
  final int stepNumber;
  final InstructionModel instruction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A2E),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              instruction.description,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
