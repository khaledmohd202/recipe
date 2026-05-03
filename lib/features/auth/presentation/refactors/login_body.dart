import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/custom_widgets.dart';
import 'package:recipe/core/extension/extensions.dart';
import 'package:recipe/core/routing/app_routes.dart';
import 'package:recipe/core/style/fonts/font_weight_helper.dart';
import 'package:recipe/core/style/icons/app_icons.dart';
import 'package:recipe/core/style/images/app_images.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Finder'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Image.asset(AppIcons.signIn),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sign-in Banner.
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: AppImage.asset(
                  assetPath: AppImages.signInBanner,
                  height: 200.h,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              // Title & Description.
              Text(
                ' Welcome Back',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeightHelper.bold,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                ' Sign in to continue your culinary journey',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.light,
                  color: Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 25.h),
              AppTextField(
                controller: _emailTextEditingController,
                label: '  Email',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                focusedBorderColor: Color(0xFFE53935),
                borderRadius: 18.r,
                borderColor: Colors.black26,
              ),
              SizedBox(height: 8.h),
              AppTextField(
                controller: _passwordTextEditingController,
                label: '  Password',
                hintText: 'Enter your Password',
                isPassword: true,
                keyboardType: TextInputType.emailAddress,
                focusedBorderColor: Color(0xFFE53935),
                borderRadius: 18.r,
                borderColor: Colors.black26,
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color(0xFFFF6E42), fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              AppElevatedButton(
                text: 'Sign In',
                onPressed: () {},
                // backgroundColor: Color(0xFFFF6E42),
                gradient: LinearGradient(
                  colors: [Color(0xFFFF7043), Color(0xFFE53935)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                textColor: Colors.white,
                borderRadius: 18.r,
              ),
              DividerContinueWith(),
              LogInWithGoogleOrFacebook(),
              DoNotHaveAnAccount(
                onTap: () {
                  context.pushNamed(AppRoutes.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoNotHaveAnAccount extends StatelessWidget {
  const DoNotHaveAnAccount({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.regular,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: Color(0xFFFF7043),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogInWithGoogleOrFacebook extends StatelessWidget {
  const LogInWithGoogleOrFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppElevatedButton.outlined(
          text: 'Google',
          width: 160.w,
          height: 60.h,
          prefixIcon: Image.asset(AppIcons.googleIcon, scale: 0.8),
          backgroundColor: Colors.white,
          textColor: Colors.black54,
          borderColor: Colors.black12,
          borderRadius: 18.r,
          onPressed: () {},
        ),
        AppElevatedButton.outlined(
          text: 'Facebook',
          width: 160.w,
          height: 60.h,
          prefixIcon: Image.asset(AppIcons.facebookIcon, scale: 0.9),
          backgroundColor: Colors.white,
          textColor: Colors.black54,
          borderColor: Colors.black12,
          borderRadius: 18.r,
          onPressed: () {},
        ),
      ],
    );
  }
}

class DividerContinueWith extends StatelessWidget {
  const DividerContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Divider(color: Colors.black26, endIndent: 10, indent: 10),
          ),
          Text(
            'or continue with',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 15.sp,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
          Expanded(
            child: Divider(color: Colors.black26, endIndent: 10, indent: 10),
          ),
        ],
      ),
    );
  }
}
