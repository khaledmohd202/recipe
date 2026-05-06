import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';
import 'package:recipe/features/meal_details/data/repo/meal_details_repo.dart';

part 'meal_details_state.dart';

class MealDetailsCubit extends Cubit<MealDetailsState> {
   final MealDetailsRepo _repo;

  MealDetailsCubit(this._repo) : super(MealDetailsInitial());

  Future<void> getMealDetail(String mealId) async {
    emit(MealDetailsLoading());
    final result = await _repo.getMealDetail(mealId);
    result.fold(
      (failure) => emit(MealDetailsError(failure.message)),
      (meal) => emit(MealDetailsSuccess(meal)),
    );
  }
}
