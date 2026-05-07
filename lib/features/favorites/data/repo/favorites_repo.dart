import 'package:dartz/dartz.dart';
import 'package:recipe/core/error/failures.dart';
import 'package:recipe/features/favorites/data/data_source/favorites_data_source.dart';
import 'package:recipe/features/favorites/data/models/favorites_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesRepo {
  final FavoritesDataSource _dataSource;

  FavoritesRepo(this._dataSource);

  Future<Either<Failure, List<FavoriteModel>>> getFavorites() async {
    try {
      final favorites = await _dataSource.getFavorites();
      return right(favorites);
    } on PostgrestException catch (e) {
      return left(SupabaseFailure(e.message));
    } catch (e) {
      return left(SupabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> addFavorite(String mealId) async {
    try {
      await _dataSource.addFavorite(mealId);
      return right(null);
    } on PostgrestException catch (e) {
      return left(SupabaseFailure(e.message));
    } catch (e) {
      return left(SupabaseFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteFavorite(String mealId) async {
    try {
      await _dataSource.deleteFavorite(mealId);
      return right(null);
    } on PostgrestException catch (e) {
      return left(SupabaseFailure(e.message));
    } catch (e) {
      return left(SupabaseFailure(e.toString()));
    }
  }

  // Future<Either<Failure, bool>> isFavorite(String mealId) async {
  //   try {
  //     final result = await _dataSource.isFavorite(mealId);
  //     return right(result);
  //   } on PostgrestException catch (e) {
  //     return left(SupabaseFailure(e.message));
  //   } catch (e) {
  //     return left(SupabaseFailure(e.toString()));
  //   }
  // }
}
