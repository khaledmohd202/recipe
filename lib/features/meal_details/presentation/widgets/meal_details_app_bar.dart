import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/app_image.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';

class MealDetailsAppBar extends StatelessWidget {
  const MealDetailsAppBar({super.key, required this.meal});
  final MealDetailModel meal;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImage(
          imageUrl: meal.imageUrl,
          width: double.infinity,
          height: 304.h,
          fit: BoxFit.cover,
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: _BackButton(),
          actions: [_FavoriteButton(meal: meal)],
        ),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: EdgeInsets.all(8.r),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.meal});
  final MealDetailModel meal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final cubit = context.read<FavoritesCubit>();
        final isFav = cubit.isFavorite(meal.id);

        return Container(
          margin: EdgeInsets.all(8.r),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: AppColors.primaryLight,
            ),
            onPressed: () => isFav
                ? cubit.deleteFavorite(meal.id)
                : cubit.addFavorite(meal.id),
          ),
        );
      },
    );
  }
}
