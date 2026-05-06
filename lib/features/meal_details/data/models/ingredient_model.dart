class IngredientModel {
  final String id;
  final String mealId;
  final String name;
  final int sortOrder;

  const IngredientModel({
    required this.id,
    required this.mealId,
    required this.name,
    required this.sortOrder,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'] as String,
      mealId: json['meal_id'] as String,
      name: json['name'] as String,
      sortOrder: json['sort_order'] as int,
    );
  }
}
