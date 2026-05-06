part of 'meal_details_cubit.dart';

@immutable
sealed class MealDetailsState {}

final class MealDetailsInitial extends MealDetailsState {}

final class MealDetailsLoading extends MealDetailsState {}

final class MealDetailsSuccess extends MealDetailsState {
  final MealDetailModel meal;
  MealDetailsSuccess(this.meal);
}

final  class MealDetailsError extends MealDetailsState {
  final String message;
  MealDetailsError(this.message);
}
