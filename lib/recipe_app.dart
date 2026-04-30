import 'package:flutter/material.dart';
import 'package:recipe/core/routing/app_routes.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key, required this.startRoute});
  final String startRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: startRoute,
    );
  }
}
