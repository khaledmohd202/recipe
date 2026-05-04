import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:recipe/core/common/widgets/custom_widgets.dart';
import 'package:recipe/core/extension/extensions.dart';
import 'package:recipe/core/routing/app_routes.dart';
import 'package:recipe/core/style/fonts/font_weight_helper.dart';
import 'package:recipe/core/style/icons/app_icons.dart';
import 'package:recipe/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:recipe/features/auth/presentation/refactors/login_body.dart';

class RegistrationBody extends StatefulWidget {
  const RegistrationBody({super.key});

  @override
  State<RegistrationBody> createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> {
  final TextEditingController _fullNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        // toolbarHeight: 70.h,
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
            icon: Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(AppIcons.signIn, scale: 0.6),
                    Text('Create Account', style: TextStyle(fontSize: 30.sp)),
                    Text(
                      'Join our community of food lovers',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                controller: _fullNameTextEditingController,
                label: '  FullName',
                hintText: 'Khaled Mohammad',
                keyboardType: TextInputType.name,
                focusedBorderColor: Color(0xFFE53935),
                borderRadius: 18.r,
                borderColor: Colors.black26,
              ),
              SizedBox(height: 8.h),
              AppTextField(
                controller: _emailTextEditingController,
                label: '  Email',
                hintText: 'khaledmohd202@gmail.com',
                keyboardType: TextInputType.emailAddress,
                focusedBorderColor: Color(0xFFE53935),
                borderRadius: 18.r,
                borderColor: Colors.black26,
              ),
              SizedBox(height: 8.h),
              AppTextField(
                controller: _passwordTextEditingController,
                label: '  Password',
                hintText: '••••••••',
                isPassword: true,
                keyboardType: TextInputType.emailAddress,
                focusedBorderColor: Color(0xFFE53935),
                borderRadius: 18.r,
                borderColor: Colors.black26,
              ),
              SizedBox(height: 25.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    context.pushNamedAndRemoveUntil(AppRoutes.login);
                  } else if (state is AuthFailure) {
                    AppToast.error(context, state.message);
                  }
                },
                builder: (context, state) {
                  return AppElevatedButton(
                    text: 'Sign Up',
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF7043), Color(0xFFE53935)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    // backgroundColor: Color(0xFFFF6E42),
                    onPressed: () {
                      context.read<AuthCubit>().signUp(
                        email: _emailTextEditingController.text.trim(),
                        password: _passwordTextEditingController.text.trim(),
                        fullName: _fullNameTextEditingController.text,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 15.h),
              DividerContinueWith(),
              LogInWithGoogleOrFacebook(),
              SizedBox(height: 15.h),

              AlreadyHaveAnAccount(
                onTap: () {
                  context.safePop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.regular,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              ' Sign In',
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
