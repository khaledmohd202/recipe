import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    required this.controller,
    super.key,
    this.onTap,
    this.onPressedFilter,
  });
  final TextEditingController controller;
  final VoidCallback? onTap;
  final VoidCallback? onPressedFilter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.grey.withValues(alpha: 0.2),
              // border: BoxBorder.all(
              //   color: Market iColors.lightBlue200Color,
              //   width: 3.w,
              // ),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Search recipes, ingredients...',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ),
                // SizedBox(width: 15.w),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
