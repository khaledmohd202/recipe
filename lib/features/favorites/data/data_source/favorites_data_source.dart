import 'package:recipe/features/favorites/data/models/favorites_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesDataSource {
  final SupabaseClient _client;

  FavoritesDataSource(this._client);

  String get _userId => _client.auth.currentUser!.id;

  Future<List<FavoriteModel>> getFavorites() async {
    final response = await _client
        .from('favorites')
        .select('*, meals(*, ingredients(*), instructions(*))')
        .eq('user_id', _userId);

    return (response as List).map((e) => FavoriteModel.fromJson(e)).toList();
  }

  Future<void> addFavorite(String mealId) async {
    await _client.from('favorites').insert({
      'user_id': _userId,
      'meal_id': mealId,
    });
  }

  Future<void> deleteFavorite(String mealId) async {
    await _client
        .from('favorites')
        .delete()
        .eq('user_id', _userId)
        .eq('meal_id', mealId);
  }

  // Future<bool> isFavorite(String mealId) async {
  //   final response = await _client
  //       .from('favorites')
  //       .select()
  //       .eq('user_id', _userId)
  //       .eq('meal_id', mealId);
  //   return (response as List).isNotEmpty;
  // }
}
