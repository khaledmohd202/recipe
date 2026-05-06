part of 'meals_cubit.dart';

@immutable
sealed class MealsState {}

final class MealsInitial extends MealsState {}

final class MealsLoading extends MealsState {}

final class MealsSuccess extends MealsState {
  final List<MealModel> meals;
  MealsSuccess(this.meals);
}

final class MealsError extends MealsState {
  final String message;
  MealsError(this.message);
}
