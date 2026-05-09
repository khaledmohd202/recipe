import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/app_image.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/core/style/images/app_images.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 90.w,
          height: 90.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200, width: 2),
          ),
          child: imageUrl != null
              ? ClipOval(child: Image.network(imageUrl!, fit: BoxFit.cover))
              : AppImage.asset(
                  assetPath: AppImages.khaledImage,
                  shape: BoxShape.circle,
                  width: 90.w,
                  height: 90.h,
                ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 26.w,
            height: 26.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.edit, color: Colors.white, size: 14.sp),
          ),
        ),
      ],
    );
  }
}
