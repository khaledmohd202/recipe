import 'package:dartz/dartz.dart';
import 'package:recipe/core/error/failures.dart';
import 'package:recipe/features/meal_details/data/data_source/meal_details_data_source.dart';
import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MealDetailsRepo {
  final MealDetailsDataSource _dataSource;

  MealDetailsRepo(this._dataSource);

  Future<Either<Failure, MealDetailModel>> getMealDetail(String mealId) async {
    try {
      final meal = await _dataSource.getMealDetails(mealId);
      return right(meal);
    } on PostgrestException catch (e) {
      return left(SupabaseFailure(e.message));
    } catch (e) {
      return left(SupabaseFailure(e.toString()));
    }
  }
}
