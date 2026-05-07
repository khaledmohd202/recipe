import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/favorites/data/models/favorites_model.dart';
import 'package:recipe/features/favorites/data/repo/favorites_repo.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._repo) : super(FavoritesInitial());

  final FavoritesRepo _repo;

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    final result = await _repo.getFavorites();
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorites) => emit(FavoritesSuccess(favorites)),
    );
  }

  Future<void> addFavorite(String mealId) async {
    final result = await _repo.addFavorite(mealId);
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (_) => getFavorites(),
    );
  }

  Future<void> deleteFavorite(String mealId) async {
    final currentState = state;
    if (currentState is! FavoritesSuccess) return;

    emit(
      FavoritesSuccess(
        currentState.favorites.where((f) => f.mealId != mealId).toList(),
      ),
    );

    final result = await _repo.deleteFavorite(mealId);
    result.fold(
      (failure) => emit(FavoritesSuccess(currentState.favorites)),
      (_) => null,
    );
  }

  bool isFavorite(String mealId) {
    final currentState = state;
    if (currentState is! FavoritesSuccess) return false;
    return currentState.favorites.any((f) => f.mealId == mealId);
  }
}
