import 'package:recipe/features/home/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeDataSource {
  HomeDataSource(this._client);

  final SupabaseClient _client;

  Future<List<CategoryModel>> getCategories() async {
    final response = await _client.from('categories').select();

    return (response as List).map((e) => CategoryModel.fromJson(e)).toList();
  }
}
