import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/app_shimmer.dart';

class MealsShimmer extends StatelessWidget {
  const MealsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.w,
        crossAxisSpacing: 15.h,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return ShimmerBox(width: 155.w, height: 180.h);
      },
    );
  }
}
