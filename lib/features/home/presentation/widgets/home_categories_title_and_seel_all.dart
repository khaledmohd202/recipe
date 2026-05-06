import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/style/colors/app_colors.dart';

class HomeCategoriesTitleAndSeeAll extends StatelessWidget {
  const HomeCategoriesTitleAndSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          ' Categories',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(
            'See All',
            style: TextStyle(color: AppColors.primaryLight, fontSize: 15.sp),
          ),
        ),
      ],
    );
  }
}
