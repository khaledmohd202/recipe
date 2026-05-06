import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/meals/data/models/meal_model.dart';
import 'package:recipe/features/meals/data/repo/meals_repo.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final MealsRepo _repo;

  MealsCubit(this._repo) : super(MealsInitial());

  final List<MealModel> meals = [];
  int skip = 0;
  final int limit = 6;
  bool hasMore = true;
  bool isLoading = false;

  String categoryId = '';
  String categoryName = '';

  Future<void> getMealsByCategory({
    required String categoryId,
    required String categoryName,
  }) async {
    this.categoryId = categoryId;
    this.categoryName = categoryName;

    if (isLoading || !hasMore) return;
    isLoading = true;

    if (meals.isEmpty) emit(MealsLoading());

    final result = await _repo.getMealsByCategory(
      categoryId: categoryId,
      skip: skip,
      limit: limit,
    );
    result.fold((failure) => emit(MealsError(failure.message)), (data) {
      skip += data.length;
      meals.addAll(data);
      hasMore = data.length == limit;
      emit(MealsSuccess(List.from(meals)));
    });
    isLoading = false;
  }

  String getCategoryName() => categoryName;
}
