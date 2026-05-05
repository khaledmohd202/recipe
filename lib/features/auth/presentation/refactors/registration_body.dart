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
import 'package:recipe/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:recipe/features/auth/presentation/bloc/sign_in_with_google_and_facebook/sign_in_with_google_and_facebook_cubit.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.pushNamedAndRemoveUntil(AppRoutes.main);
            } else if (state is AuthFailure) {
              AppToast.error(context, state.message);
            }
          },
        ),
        BlocListener<
          SignInWithGoogleAndFacebookCubit,
          SignInWithGoogleAndFacebookState
        >(
          listener: (context, state) {
            if (state is GoogleSignInSuccess ||
                state is FacebookSignInSuccess) {
              context.pushNamedAndRemoveUntil(AppRoutes.main);
            } else if (state is GoogleSignInFailure) {
              AppToast.error(context, state.errorMessage);
            } else if (state is FacebookSignInFailure) {
              AppToast.error(context, state.errorMessage);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
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
              onPressed: () =>
                  context.read<LocalizationCubit>().toggleLanguage(),
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
                Center(
                  child: Column(
                    children: [
                      Image.asset(AppIcons.signIn, scale: 0.6),
                      Text(
                        context.transl(LangKeys.createAccount),
                        style: TextStyle(fontSize: 30.sp),
                      ),
                      Text(
                        context.transl(LangKeys.signUpSubtitle),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: _fullNameTextEditingController,
                  label: context.transl(LangKeys.fullName),
                  hintText: context.transl(LangKeys.fullNameHint),
                  keyboardType: TextInputType.name,
                  focusedBorderColor: const Color(0xFFE53935),
                  borderRadius: 18.r,
                  borderColor: Colors.black26,
                ),
                SizedBox(height: 8.h),
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
                  hintText: '••••••••',
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  focusedBorderColor: const Color(0xFFE53935),
                  borderRadius: 18.r,
                  borderColor: Colors.black26,
                ),
                SizedBox(height: 25.h),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AppElevatedButton(
                      text: context.transl(LangKeys.signUp),
                      isLoading: state is AuthLoading,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF7043), Color(0xFFE53935)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().signUp(
                          email: _emailTextEditingController.text.trim(),
                          password: _passwordTextEditingController.text.trim(),
                          fullName: _fullNameTextEditingController.text.trim(),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 15.h),
                const DividerContinueWith(),
                const LogInWithGoogleOrFacebook(),
                SizedBox(height: 15.h),
                AlreadyHaveAnAccount(onTap: () => context.safePop()),
              ],
            ),
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
            context.transl(LangKeys.haveAccount),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.regular,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              context.transl(LangKeys.signIn),
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
