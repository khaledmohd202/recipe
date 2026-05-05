import 'package:get_it/get_it.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:recipe/features/auth/data/data_source/auth_data_source.dart';
import 'package:recipe/features/auth/data/repo/auth_repo.dart';
import 'package:recipe/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:recipe/features/auth/presentation/bloc/sign_in_with_google_and_facebook/sign_in_with_google_and_facebook_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> setupInjector() async {
  await _initCore();
  await _initAuth();
  await _initAuthWithGoogleAndFacebook();
}

Future<void> _initAuthWithGoogleAndFacebook() async {
  sl.registerFactory(() => SignInWithGoogleAndFacebookCubit());
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
