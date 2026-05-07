import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/style/colors/app_colors.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(Icons.logout, color: AppColors.primaryLight),
        label: Text(
          'Logout',
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
