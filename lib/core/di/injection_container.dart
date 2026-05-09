import 'package:get_it/get_it.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:recipe/features/auth/data/data_source/auth_data_source.dart';
import 'package:recipe/features/auth/data/repo/auth_repo.dart';
import 'package:recipe/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:recipe/features/auth/presentation/bloc/sign_in_with_google_and_facebook/sign_in_with_google_and_facebook_cubit.dart';
import 'package:recipe/features/favorites/data/data_source/favorites_data_source.dart';
import 'package:recipe/features/favorites/data/repo/favorites_repo.dart';
import 'package:recipe/features/favorites/presentation/bloc/favorites_cubit.dart';
import 'package:recipe/features/home/data/data_source/home_data_source.dart';
import 'package:recipe/features/home/data/repo/home_repo.dart';
import 'package:recipe/features/home/presentation/bloc/home_cubit.dart';
import 'package:recipe/features/meal_details/data/data_source/meal_details_data_source.dart';
import 'package:recipe/features/meal_details/data/repo/meal_details_repo.dart';
import 'package:recipe/features/meal_details/presentation/bloc/meal_details_cubit.dart';
import 'package:recipe/features/meals/data/data_source/meals_data_source.dart';
import 'package:recipe/features/meals/data/repo/meals_repo.dart';
import 'package:recipe/features/meals/presentation/bloc/meals_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> setupInjector() async {
  await _initCore();
  await _initAuth();
  await _initAuthWithGoogleAndFacebook();
  await _initHome();
  await _initMeals();
  await _initMealDetail();
  await _initFavorites();
}

Future<void> _initCore() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl()));
  sl.registerLazySingleton<LocalizationCubit>(() => LocalizationCubit(sl()));
}

Future<void> _initAuth() async {
  sl
    ..registerLazySingleton<AuthDataSource>(() => AuthDataSource(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepo(sl()))
    ..registerFactory<AuthCubit>(() => AuthCubit(sl()));
}

Future<void> _initAuthWithGoogleAndFacebook() async {
  sl.registerFactory(() => SignInWithGoogleAndFacebookCubit());
}

Future<void> _initHome() async {
  sl
    ..registerLazySingleton<HomeDataSource>(() => HomeDataSource(sl()))
    ..registerLazySingleton<HomeRepo>(() => HomeRepo(sl()))
    ..registerLazySingleton<HomeCubit>(() => HomeCubit(sl()));
}

Future<void> _initMeals() async {
  sl
    ..registerLazySingleton<MealsDataSource>(() => MealsDataSource(sl()))
    ..registerLazySingleton<MealsRepo>(() => MealsRepo(sl()))
    ..registerFactory<MealsCubit>(() => MealsCubit(sl()));
}

Future<void> _initMealDetail() async {
  sl
    ..registerLazySingleton<MealDetailsDataSource>(
      () => MealDetailsDataSource(sl()),
    )
    ..registerLazySingleton<MealDetailsRepo>(() => MealDetailsRepo(sl()))
    ..registerFactory<MealDetailsCubit>(() => MealDetailsCubit(sl()));
}

Future<void> _initFavorites() async {
  sl
    ..registerLazySingleton<FavoritesDataSource>(
      () => FavoritesDataSource(sl()),
    )
    ..registerLazySingleton<FavoritesRepo>(() => FavoritesRepo(sl()))
    ..registerLazySingleton<FavoritesCubit>(() => FavoritesCubit(sl()));
}
