import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';
import 'package:recipe/core/languages/app_localizations_setup.dart';
import 'package:recipe/core/routing/app_routes.dart';
import 'package:recipe/core/style/theme/app_theme.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key, required this.startRoute});
  final String startRoute;

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocalizationCubit>().state;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Theme Init.
        themeMode: themeMode,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        // Localization Init.
        locale: locale,
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
        localeResolutionCallback:
            AppLocalizationsSetup.localeResolutionCallback,
        // Routing.
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: startRoute,
      ),
    );
  }
}
