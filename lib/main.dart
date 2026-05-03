import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:recipe/core/di/injection_container.dart';
import 'package:recipe/core/routing/app_routes.dart';
import 'package:recipe/recipe_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  await setupInjector();

  String startRoute = AppRoutes.splash;

  // if (seenOnboarding == null) {
  //   startRoute = AppRoutes.onboarding;
  // } else if (token != null) {
  //   startRoute = AppRoutes.main;
  // } else {
  //   startRoute = AppRoutes.signIn;
  // }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ThemeCubit>()),
        BlocProvider.value(value: sl<LocalizationCubit>()),
      ],
      child: RecipeApp(startRoute: startRoute),
    ),
  );

  FlutterNativeSplash.remove();
}
