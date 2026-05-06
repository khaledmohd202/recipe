import 'package:dartz/dartz.dart';
import 'package:recipe/core/error/failures.dart';
import 'package:recipe/features/meals/data/data_source/meals_data_source.dart';
import 'package:recipe/features/meals/data/models/meal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MealsRepo {
  final MealsDataSource _dataSource;

  MealsRepo(this._dataSource);

  Future<Either<Failure, List<MealModel>>> getMealsByCategory(
    String categoryId,
  ) async {
    try {
      final meals = await _dataSource.getMealsByCategory(categoryId);
      return right(meals);
    } on PostgrestException catch (e) {
      return left(SupabaseFailure(e.message));
    } catch (e) {
      return left(SupabaseFailure(e.toString()));
    }
  }
}
