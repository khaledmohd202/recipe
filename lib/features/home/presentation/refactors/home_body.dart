import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/custom_widgets.dart';
import 'package:recipe/core/extension/extensions.dart';
import 'package:recipe/core/routing/app_routes.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/core/style/icons/app_icons.dart';
import 'package:recipe/features/home/presentation/bloc/home_cubit.dart';
import 'package:recipe/features/home/presentation/widgets/home_search_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'Recipe Finder',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        leadingWidth: 500.w,
        automaticallyImplyLeading: false,
        actions: [Image.asset(AppIcons.signIn, scale: 0.9)],
        actionsPadding: EdgeInsets.only(right: 10.w),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Expanded(child: ShimmerProductCard());
        }
        if (state is HomeError) {
          return Expanded(child: DefaultErrorWidget(message: state.message));
        }
        if (state is HomeSuccess) {
          return Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.w,
                crossAxisSpacing: 15.h,
                childAspectRatio: 0.8,
                // mainAxisExtent: 100.h,
              ),
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.meals, arguments: category.id);
                  },
                  child: Container(
                    width: 155.w,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Stack(
                      children: [
                        AppImage(
                          imageUrl: category.imageUrl,
                          fit: BoxFit.fill,
                          height: double.infinity,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        Positioned(
                          bottom: 10.h,
                          left: 10.w,
                          child: Text(
                            category.name.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class HomeCategoriesTitleAndSeeAll extends StatelessWidget {
  const HomeCategoriesTitleAndSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          ' Categories',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(
            'See All',
            style: TextStyle(color: AppColors.primaryLight, fontSize: 15.sp),
          ),
        ),
      ],
    );
  }
}
