import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
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
      child: const _ProfileView(),
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
          'Profile',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
              'Alex Johnson',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),
            Text(
              'alex.j@example.com',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey),
            ),
            SizedBox(height: 30.h),

            // ACCOUNT
            const ProfileSectionTitle(title: 'ACCOUNT'),
            SizedBox(height: 8.h),
            ProfileTile(
              icon: Icons.person_outline,
              label: 'Edit Profile',
              onTap: () {},
            ),
            ProfileTile(
              icon: Icons.lock_outline,
              label: 'Change Password',
              onTap: () {},
            ),
            ProfileTile(
              icon: Icons.notifications_outlined,
              label: 'Notification Settings',
              onTap: () {},
            ),
            SizedBox(height: 20.h),

            // PREFERENCES
            const ProfileSectionTitle(title: 'PREFERENCES'),
            SizedBox(height: 8.h),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeState) {
                return ProfileTile(
                  icon: Icons.dark_mode_outlined,
                  label: 'Dark Mode',
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
                  label: 'Language',
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
            const ProfileSectionTitle(title: 'SUPPORT'),
            SizedBox(height: 8.h),
            ProfileTile(
              icon: Icons.help_outline,
              label: 'Help Center',
              onTap: () {},
            ),
            ProfileTile(
              icon: Icons.shield_outlined,
              label: 'Privacy Policy',
              onTap: () {},
            ),
            ProfileTile(
              icon: Icons.description_outlined,
              label: 'Terms of Service',
              onTap: () {},
            ),
            SizedBox(height: 24.h),

            ProfileLogoutButton(onTap: () {}),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
