import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/app_image.dart';
import 'package:recipe/core/common/widgets/app_list_fallback_widget.dart';
import 'package:recipe/core/common/widgets/app_shimmer.dart';
import 'package:recipe/core/extension/context_extension.dart';
import 'package:recipe/core/routing/app_routes.dart';
import 'package:recipe/features/home/presentation/bloc/home_cubit.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              // padding: EdgeInsets.symmetric(horizontal: 15.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.w,
                crossAxisSpacing: 15.h,
                childAspectRatio: 0.8,
                mainAxisExtent: 200.h,
              ),
              itemBuilder: (context, index) {
                return ShimmerBox(width: 155.w, height: 180.h);
              },
            ),
          );
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
                    context.pushNamed(
                      AppRoutes.meals,
                      arguments: {
                        'categoryId': category.id.toString(),
                        'categoryName': category.name,
                      },
                    );
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
                          // errorWidget: ,
                        ),
                        Positioned(
                          bottom: 10.h,
                          left: 10.w,
                          child: Text(
                            category.name.toUpperCase(),
                            style: TextStyle(
                              color: context.colorScheme.surface,
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
