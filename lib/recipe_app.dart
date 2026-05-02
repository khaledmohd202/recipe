import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/routing/app_routes.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key, required this.startRoute});
  final String startRoute;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'PlusJakartaSans'),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: startRoute,
      ),
    );
  }
}
