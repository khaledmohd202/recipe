import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/style/colors/app_colors.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    required this.activeIcon,
    required this.currentIndex,
    required this.icon,
    required this.index,
    required this.label,
    required this.onTap,
    super.key,
  });
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected
                  ? AppColors.primaryLight
                  : Colors.grey,
            ),
            Text(
               label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
