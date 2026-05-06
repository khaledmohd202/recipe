import 'package:recipe/features/meals/data/models/meal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MealsDataSource {
  MealsDataSource(this._client);

  final SupabaseClient _client;

  Future<List<MealModel>> getMealsByCategory({
    required String categoryId,
    required int skip,
    required int limit,
  }) async {
    final response = await _client
        .from('meals')
        .select()
        .eq('category_id', categoryId)
        .range(skip, skip + limit - 1);

    return (response as List).map((e) => MealModel.fromJson(e)).toList();
  }
}
