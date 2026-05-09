import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/common/widgets/app_list_fallback_widget.dart';
import 'package:recipe/core/extension/context_extension.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_cubit.dart';
import 'package:recipe/features/meals/presentation/widgets/meals_grid.dart';
import 'package:recipe/features/meals/presentation/widgets/meals_shimmer.dart';

class MealsBody extends StatefulWidget {
  const MealsBody({super.key});

  @override
  State<MealsBody> createState() => _MealsBodyState();
}

class _MealsBodyState extends State<MealsBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      final cubit = context.read<MealsCubit>();

      cubit.getMealsByCategory(
        categoryId: cubit.categoryId,
        categoryName: cubit.categoryName,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MealsCubit>();
    final categoryName = cubit.getCategoryName();

    return Scaffold(
      appBar: AppBar(
        leading: Transform.scale(
          scale: 1.2,
          child: BackButton(color: AppColors.primaryLight),
        ),
        title: Text(
          context.localization.translateCategory(categoryName).toUpperCase(),
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsLoading && cubit.meals.isEmpty) {
            return MealsShimmer();
          }

          if (state is MealsError) {
            return DefaultErrorWidget(message: state.message);
          }

          if (state is MealsSuccess) {
            return MealsGrid(scrollController: _scrollController);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
