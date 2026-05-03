import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:recipe/core/common/widgets/custom_widgets.dart';
import 'package:recipe/core/extension/extensions.dart';
import 'package:recipe/core/languages/lang_keys.dart';
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
        title: Text(context.transl(LangKeys.appName)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Image.asset(AppIcons.signIn),
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: Icon(
              context.watch<ThemeCubit>().isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
          IconButton(
            onPressed: () => context.read<LocalizationCubit>().toggleLanguage(),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: AppImage.asset(
                  assetPath: AppImages.signInBanner,
                  height: 200.h,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              Text(
                context.transl(LangKeys.welcomeBack),
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeightHelper.bold,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                context.transl(LangKeys.signInSubtitle),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.light,
                  color: const Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 25.h),
              AppTextField(
                controller: _emailTextEditingController,
                label: context.transl(LangKeys.email),
                hintText: context.transl(LangKeys.emailHint),
                keyboardType: TextInputType.emailAddress,
                focusedBorderColor: const Color(0xFFE53935),
                borderRadius: 18.r,
                borderColor: Colors.black26,
              ),
              SizedBox(height: 8.h),
              AppTextField(
                controller: _passwordTextEditingController,
                label: context.transl(LangKeys.password),
                hintText: context.transl(LangKeys.passwordHint),
                isPassword: true,
                keyboardType: TextInputType.emailAddress,
                focusedBorderColor: const Color(0xFFE53935),
                borderRadius: 18.r,
                borderColor: Colors.black26,
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    context.transl(LangKeys.forgotPassword),
                    style: TextStyle(
                      color: const Color(0xFFFF6E42),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              AppElevatedButton(
                text: context.transl(LangKeys.signIn),
                onPressed: () {},
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF7043), Color(0xFFE53935)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                textColor: Colors.white,
                borderRadius: 18.r,
              ),
              const DividerContinueWith(),
              const LogInWithGoogleOrFacebook(),
              DoNotHaveAnAccount(
                onTap: () => context.pushNamed(AppRoutes.register),
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
            context.transl(LangKeys.noAccount),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.regular,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              context.transl(LangKeys.signUp),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: const Color(0xFFFF7043),
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
          text: context.transl(LangKeys.google),
          width: 160.w,
          height: 60.h,
          prefixIcon: Image.asset(AppIcons.googleIcon, scale: 0.8),
          backgroundColor: context.colorScheme.surface,
          textColor: context.colorScheme.onSurface,
          borderColor: context.colorScheme.outlineVariant,
          borderRadius: 18.r,
          onPressed: () {},
        ),
        AppElevatedButton.outlined(
          text: context.transl(LangKeys.apple),
          width: 160.w,
          height: 60.h,
          prefixIcon: Image.asset(AppIcons.facebookIcon, scale: 0.9),
          backgroundColor: context.colorScheme.surface,
          textColor: context.colorScheme.onSurface,
          borderColor: context.colorScheme.outlineVariant,
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
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: context.colorScheme.outlineVariant,
              endIndent: 10,
              indent: 10,
            ),
          ),
          Text(
            context.transl(LangKeys.orContinueWith),
            style: TextStyle(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              fontSize: 15.sp,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
          Expanded(
            child: Divider(
              color: context.colorScheme.outlineVariant,
              endIndent: 10,
              indent: 10,
            ),
          ),
        ],
      ),
    );
  }
}
