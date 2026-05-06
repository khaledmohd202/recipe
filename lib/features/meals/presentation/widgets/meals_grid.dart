import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/app_shimmer.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_cubit.dart';
import 'package:recipe/features/meals/presentation/widgets/meals_card.dart';

class MealsGrid extends StatelessWidget {
  const MealsGrid({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MealsCubit>();

    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      itemCount: cubit.meals.length + (cubit.hasMore ? 2 : 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.w,
        crossAxisSpacing: 15.h,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        if (index < cubit.meals.length) {
          final meal = cubit.meals[index];
          return MealCard(meal: meal);
        }
        return ShimmerBox(width: double.infinity, height: double.infinity);
      },
    );
  }
}
