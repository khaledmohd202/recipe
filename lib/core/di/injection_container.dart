import 'package:get_it/get_it.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupInjector() async {
  await _initCore();
  await _initAuth();
}

Future<void> _initCore() async {

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl()));
  sl.registerLazySingleton<LocalizationCubit>(() => LocalizationCubit(sl()));
}

Future<void> _initAuth() async {
  // sl.registerFactory(() => AuthCubit(sl()))
  // sl.registerLazySingleton(() => AuthRepo(sl()))
  // sl.registerLazySingleton(() => AuthDataSource(sl()))
}


