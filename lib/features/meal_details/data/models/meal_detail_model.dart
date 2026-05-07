import 'package:recipe/features/meal_details/data/models/ingredient_model.dart';
import 'package:recipe/features/meal_details/data/models/instruction_model.dart';

class MealDetailModel {
  final String id;
  final String categoryId;
  final String name;
  final String imageUrl;
  final int cookedTime;
  final String country;
  final String mealSection;
  final String cookingLevel;
  final int kcal;
  final List<IngredientModel> ingredients;
  final List<InstructionModel> instructions;

  const MealDetailModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.imageUrl,
    required this.cookedTime,
    required this.country,
    required this.mealSection,
    required this.cookingLevel,
    required this.kcal,
    required this.ingredients,
    required this.instructions,
  });

  factory MealDetailModel.fromJson(Map<String, dynamic> json) {
    final instructions =
        (json['instructions'] as List)
            .map((e) => InstructionModel.fromJson(e))
            .toList()
          ..sort((a, b) => a.stepNumber.compareTo(b.stepNumber));

    return MealDetailModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      cookedTime: json['cooked_time'] as int,
      country: json['country'] as String,
      mealSection: json['meal_section'] as String,
      cookingLevel: json['cooking_level'] as String,
      kcal: json['kcal'] as int,
      ingredients: (json['ingredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
      instructions: instructions,
    );
  }
}
