class MealModel {
  final String id;
  final String categoryId;
  final String name;
  final String imageUrl;
  final int cookedTime;
  final String country;
  final String mealSection;
  final String cookingLevel;
  final int kcal;

  const MealModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.imageUrl,
    required this.cookedTime,
    required this.country,
    required this.mealSection,
    required this.cookingLevel,
    required this.kcal,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      cookedTime: json['cooked_time'] as int,
      country: json['country'] as String,
      mealSection: json['meal_section'] as String,
      cookingLevel: json['cooking_level'] as String,
      kcal: json['kcal'] as int,
    );
  }
}
