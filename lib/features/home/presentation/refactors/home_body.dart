import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/extension/context_extension.dart';
import 'package:recipe/core/languages/lang_keys.dart';
import 'package:recipe/core/style/icons/app_icons.dart';
import 'package:recipe/features/home/presentation/widgets/home_categories_title_and_seel_all.dart';
import 'package:recipe/features/home/presentation/widgets/home_grid_view.dart';
import 'package:recipe/features/home/presentation/widgets/home_search_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Align(
          alignment: context.isArabic
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              context.transl(LangKeys.appName),
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        leadingWidth: 500.w,
        automaticallyImplyLeading: false,
        actions: [Image.asset(AppIcons.signIn, scale: 0.9)],
        actionsPadding: EdgeInsets.only(right: 10.w, left: 10.w),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeSearchBar(controller: TextEditingController(), onTap: () {}),
            HomeCategoriesTitleAndSeeAll(),
            HomeGridView(),
          ],
        ),
      ),
    );
  }
}
