import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:recipe/core/routing/app_routes.dart';
import 'package:recipe/recipe_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

   String startRoute = AppRoutes.splash;

  // if (seenOnboarding == null) {
  //   startRoute = AppRoutes.onboarding;
  // } else if (token != null) {
  //   startRoute = AppRoutes.main;
  // } else {
  //   startRoute = AppRoutes.signIn;
  // }

  runApp(RecipeApp(startRoute: startRoute,));

  FlutterNativeSplash.remove();
}
