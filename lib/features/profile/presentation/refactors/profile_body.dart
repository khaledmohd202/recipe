import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:recipe/core/common/widgets/app_dialog.dart';
import 'package:recipe/core/di/injection_container.dart';
import 'package:recipe/core/extension/context_extension.dart';
import 'package:recipe/core/languages/lang_keys.dart';
import 'package:recipe/core/routing/app_routes.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:recipe/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:recipe/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:recipe/features/profile/presentation/widgets/profile_logout_button.dart';
import 'package:recipe/features/profile/presentation/widgets/profile_section_title.dart';
import 'package:recipe/features/profile/presentation/widgets/profile_tile.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(
        context.read<ThemeCubit>(),
        context.read<LocalizationCubit>(),
      ),
      child: BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSignedOut) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (_) => false,
              );
            }
          },
          child: const _ProfileView(),
        ),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          context.transl(LangKeys.profile),
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const ProfileAvatar(),
            SizedBox(height: 12.h),
            Text(
              context.transl(LangKeys.account),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),
            Text(
              'khaledmohd202@gmail.com',
              // context.transl(LangKeys.email),
              style: TextStyle(fontSize: 13.sp, color: Colors.grey),
            ),
            SizedBox(height: 30.h),

            // ACCOUNT
            ProfileSectionTitle(title: context.transl(LangKeys.account)),
            SizedBox(height: 8.h),
            ProfileTile(
              icon: Icons.person_outline,
              label: context.transl(LangKeys.editProfile),
              onTap: () {},
            ),
            ProfileTile(
              icon: Icons.lock_outline,
              label: context.transl(LangKeys.changePassword),
              onTap: () {},
            ),
            ProfileTile(
              icon: Icons.notifications_outlined,
              label: context.transl(LangKeys.notificationSettings),
              onTap: () {},
            ),
            SizedBox(height: 20.h),

            // PREFERENCES
            ProfileSectionTitle(title: context.transl(LangKeys.preferences)),
            SizedBox(height: 8.h),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeState) {
                return ProfileTile(
                  icon: Icons.dark_mode_outlined,
                  label: context.transl(LangKeys.darkMode),
                  onTap: cubit.toggleTheme,
                  trailing: Switch(
                    value: cubit.isDark,
                    onChanged: (_) => cubit.toggleTheme(),
                    activeThumbColor: AppColors.primaryLight,
                  ),
                );
              },
            ),
            BlocBuilder<LocalizationCubit, Locale>(
              builder: (context, localeState) {
                return ProfileTile(
                  icon: Icons.language_outlined,
                  label: context.transl(LangKeys.language),
                  onTap: cubit.toggleLanguage,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        cubit.isArabic ? 'Arabic' : 'English',
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                        size: 20.sp,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),

            // SUPPORT
            ProfileSectionTitle(title: context.transl(LangKeys.support)),
            SizedBox(height: 8.h),
            ProfileTile(
              icon: Icons.help_outline,
              label: context.transl(LangKeys.helpCenter),
              onTap: () {},
            ),
            ProfileTile(
              icon: Icons.shield_outlined,
              label: context.transl(LangKeys.privacyPolicy),
              onTap: () {},
            ),
            ProfileTile(
              icon: Icons.description_outlined,
              label: context.transl(LangKeys.termsOfService),
              onTap: () {},
            ),
            SizedBox(height: 24.h),

            ProfileLogoutButton(
              onTap: () async {
                final confirmed = await AppDialog.confirm(
                  context,
                  title: context.transl(LangKeys.logOut),
                  message: context.transl(LangKeys.logOutConfirm),
                  confirmText: context.transl(LangKeys.logOut),
                  cancelText: context.transl(LangKeys.cancel),
                  isDestructive: true,
                );
                if (confirmed == true && context.mounted) {
                  context.read<AuthCubit>().signOut();
                }
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
