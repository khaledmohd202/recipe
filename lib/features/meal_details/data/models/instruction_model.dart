class InstructionModel {
  final String id;
  final String mealId;
  final int stepNumber;
  final String description;

  const InstructionModel({
    required this.id,
    required this.mealId,
    required this.stepNumber,
    required this.description,
  });

  factory InstructionModel.fromJson(Map<String, dynamic> json) {
    return InstructionModel(
      id: json['id'] as String,
      mealId: json['meal_id'] as String,
      stepNumber: json['step_number'] as int,
      description: json['description'] as String,
    );
  }
}
