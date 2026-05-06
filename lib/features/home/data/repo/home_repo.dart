import 'package:dartz/dartz.dart';
import 'package:recipe/core/error/failures.dart';
import 'package:recipe/features/home/data/data_source/home_data_source.dart';
import 'package:recipe/features/home/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepo {
  HomeRepo(this._dataSource);

  final HomeDataSource _dataSource;

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
     try {
      final categories = await _dataSource.getCategories();
      return right(categories);
    } on PostgrestException catch (e) {
      return left(SupabaseFailure(e.message));
    } catch (e) {
      return left(SupabaseFailure(e.toString()));
    }
  }
}
