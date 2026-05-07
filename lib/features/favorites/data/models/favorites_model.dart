import 'package:recipe/features/meal_details/data/models/meal_detail_model.dart';

class FavoriteModel {
  final String id;
  final String userId;
  final String mealId;
  final MealDetailModel meal;

  const FavoriteModel({
    required this.id,
    required this.userId,
    required this.mealId,
    required this.meal,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      mealId: json['meal_id'] as String,
      meal: MealDetailModel.fromJson(json['meals'] as Map<String, dynamic>),
    );
  }
}
