import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/app_list_fallback_widget.dart';
import 'package:recipe/core/extension/context_extension.dart';
import 'package:recipe/core/languages/lang_keys.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:recipe/features/favorites/presentation/widgets/favorites_grid.dart';
import 'package:recipe/features/favorites/presentation/widgets/favorites_shimmer.dart';

class FavoritesBody extends StatefulWidget {
  const FavoritesBody({super.key});

  @override
  State<FavoritesBody> createState() => _FavoritesBodyState();
}

class _FavoritesBodyState extends State<FavoritesBody> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          context.transl(LangKeys.myFavorites),
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const FavoritesShimmer();
          }
          if (state is FavoritesError) {
            return DefaultErrorWidget(message: state.message);
          }
          if (state is FavoritesSuccess) {
            if (state.favorites.isEmpty) return const DefaultEmptyWidget();
            return const FavoritesGrid();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
