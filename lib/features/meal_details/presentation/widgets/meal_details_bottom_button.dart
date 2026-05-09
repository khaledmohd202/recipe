import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/extension/context_extension.dart';
import 'package:recipe/core/languages/lang_keys.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';

class MealDetailsBottomButton extends StatelessWidget {
  const MealDetailsBottomButton({super.key, required this.meal});
  final MealDetailModel meal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final cubit = context.read<FavoritesCubit>();
        final isFav = cubit.isFavorite(meal.id);

        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryLight.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () => isFav
                  ? cubit.deleteFavorite(meal.id)
                  : cubit.addFavorite(meal.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              icon: Icon(
                isFav ? Icons.bookmark : Icons.bookmark_border,
                color: context.colorScheme.surface,
              ),
              label: Text(
                isFav
                    ? context.transl(LangKeys.removeFromFavorites)
                    : context.transl(LangKeys.addToFavorites),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.surface,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
