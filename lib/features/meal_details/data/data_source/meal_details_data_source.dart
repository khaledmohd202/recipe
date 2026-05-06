import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MealDetailsDataSource {
  MealDetailsDataSource(this._client);

  final SupabaseClient _client;

  Future<MealDetailModel> getMealDetails(String mealId) async {
    final response = await _client
        .from('meals')
        .select('*, ingredients(*), instructions(order: step_number.asc)')
        .eq('id', mealId)
        .single();

    return MealDetailModel.fromJson(response);
  }
}
