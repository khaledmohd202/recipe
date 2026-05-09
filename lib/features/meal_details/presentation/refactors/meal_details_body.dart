import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/extension/context_extension.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';
import 'package:recipe/features/meal_details/presentation/bloc/meal_details_cubit.dart';
import 'package:recipe/features/meal_details/presentation/widgets/meal_details_app_bar.dart';
import 'package:recipe/features/meal_details/presentation/widgets/meal_details_bottom_button.dart';
import 'package:recipe/features/meal_details/presentation/widgets/meal_details_ingredients.dart';
import 'package:recipe/features/meal_details/presentation/widgets/meal_details_instructions.dart';
import 'package:recipe/features/meal_details/presentation/widgets/meal_details_stats.dart';
import 'package:recipe/features/meal_details/presentation/widgets/meal_details_tags.dart';

class MealDetailsBody extends StatefulWidget {
  const MealDetailsBody({super.key});

  @override
  State<MealDetailsBody> createState() => _MealDetailsBodyState();
}

class _MealDetailsBodyState extends State<MealDetailsBody> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MealDetailsCubit, MealDetailsState>(
        builder: (context, state) {
          if (state is MealDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MealDetailsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is MealDetailsSuccess) {
            final meal = state.meal;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MealDetailsAppBar(meal: meal),
                      Transform.translate(
                        offset: Offset(0, -20.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24.r),
                            ),
                          ),
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MealDetailsTags(meal: meal),
                              SizedBox(height: 12.h),
                              _TitleText(meal: meal),
                              SizedBox(height: 16.h),
                              MealDetailsStats(meal: meal),
                              SizedBox(height: 24.h),
                              MealDetailsIngredients(meal: meal),
                              SizedBox(height: 24.h),
                              MealDetailsInstructions(meal: meal),
                              SizedBox(height: 40.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MealDetailsBottomButton(meal: meal),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({required this.meal});
  final MealDetailModel meal;

  @override
  Widget build(BuildContext context) {
    return Text(
      context.localization.translateMeal(meal.name),
      style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
    );
  }
}
