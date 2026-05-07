import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:recipe/features/favorites/presentation/widgets/favorite_card.dart';

class FavoritesGrid extends StatelessWidget {
  const FavoritesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<FavoritesCubit>();
    final state = cubit.state as FavoritesSuccess;

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      itemCount: state.favorites.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.w,
        crossAxisSpacing: 15.h,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return FavoriteCard(model: state.favorites[index]);
      },
    );
  }
}
