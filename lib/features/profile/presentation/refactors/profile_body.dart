// features/profile/presentation/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/style/colors/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // ── Avatar ──
            Stack(
              children: [
                Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://via.placeholder.com/90',
                      fit: BoxFit.cover,
                    ),
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
            ),
            SizedBox(height: 12.h),

            // ── Name & Email ──
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

            // ── ACCOUNT ──
            _SectionTitle(title: 'ACCOUNT'),
            SizedBox(height: 8.h),
            _ProfileTile(
              icon: Icons.person_outline,
              label: 'Edit Profile',
              onTap: () {},
            ),
            _ProfileTile(
              icon: Icons.lock_outline,
              label: 'Change Password',
              onTap: () {},
            ),
            _ProfileTile(
              icon: Icons.notifications_outlined,
              label: 'Notification Settings',
              onTap: () {},
            ),
            SizedBox(height: 20.h),

            // ── PREFERENCES ──
            _SectionTitle(title: 'PREFERENCES'),
            SizedBox(height: 8.h),
            _ProfileTileWithToggle(
              icon: Icons.dark_mode_outlined,
              label: 'Dark Mode',
            ),
            _ProfileTileWithTrailing(
              icon: Icons.language_outlined,
              label: 'Language',
              trailing: 'English',
              onTap: () {},
            ),
            SizedBox(height: 20.h),

            // ── SUPPORT ──
            _SectionTitle(title: 'SUPPORT'),
            SizedBox(height: 8.h),
            _ProfileTile(
              icon: Icons.help_outline,
              label: 'Help Center',
              onTap: () {},
            ),
            _ProfileTile(
              icon: Icons.shield_outlined,
              label: 'Privacy Policy',
              onTap: () {},
            ),
            _ProfileTile(
              icon: Icons.description_outlined,
              label: 'Terms of Service',
              onTap: () {},
            ),
            SizedBox(height: 24.h),

            // ── Logout ──
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextButton.icon(
                onPressed: () {},
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
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        leading: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColors.primaryLight, size: 18.sp),
        ),
        title: Text(label, style: TextStyle(fontSize: 14.sp)),
        trailing: Icon(Icons.chevron_right, color: Colors.grey, size: 20.sp),
        onTap: onTap,
      ),
    );
  }
}

class _ProfileTileWithToggle extends StatefulWidget {
  final IconData icon;
  final String label;
  const _ProfileTileWithToggle({required this.icon, required this.label});

  @override
  State<_ProfileTileWithToggle> createState() => _ProfileTileWithToggleState();
}

class _ProfileTileWithToggleState extends State<_ProfileTileWithToggle> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        leading: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(widget.icon, color: AppColors.primaryLight, size: 18.sp),
        ),
        title: Text(widget.label, style: TextStyle(fontSize: 14.sp)),
        trailing: Switch(
          value: _value,
          onChanged: (val) => setState(() => _value = val),
          activeColor: AppColors.primaryLight,
        ),
      ),
    );
  }
}

class _ProfileTileWithTrailing extends StatelessWidget {
  final IconData icon;
  final String label;
  final String trailing;
  final VoidCallback onTap;
  const _ProfileTileWithTrailing({
    required this.icon,
    required this.label,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        leading: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColors.primaryLight, size: 18.sp),
        ),
        title: Text(label, style: TextStyle(fontSize: 14.sp)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              trailing,
              style: TextStyle(color: AppColors.primaryLight, fontSize: 13.sp),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: Colors.grey, size: 20.sp),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
