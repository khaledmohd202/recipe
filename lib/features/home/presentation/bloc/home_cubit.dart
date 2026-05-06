
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/home/data/models/category_model.dart';
import 'package:recipe/features/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _repo;

  HomeCubit(this._repo) : super(HomeInitial());

  Future<void> getCategories() async {
    emit(HomeLoading());
    final result = await _repo.getCategories();
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (categories) => emit(HomeSuccess(categories)),
    );
  }
}
