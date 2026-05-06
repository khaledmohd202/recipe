import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/meals/data/models/meal_model.dart';
import 'package:recipe/features/meals/data/repo/meals_repo.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final MealsRepo _repo;

  MealsCubit(this._repo) : super(MealsInitial());

  Future<void> getMealsByCategory(String categoryId) async {
    emit(MealsLoading());
    final result = await _repo.getMealsByCategory(categoryId);
    result.fold(
      (failure) => emit(MealsError(failure.message)),
      (meals) => emit(MealsSuccess(meals)),
    );
  }
}
