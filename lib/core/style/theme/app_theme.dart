import 'package:flutter/material.dart';
import 'package:recipe/core/style/colors/app_colors.dart';
import 'package:recipe/core/style/theme/colors_extension.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'PlusJakartaSans',
    scaffoldBackgroundColor: AppColors.lightBackground,
    extensions: const <ThemeExtension<dynamic>>[MyColors.light],
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: Color(0xFFFFFFFF),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 14,
        color: AppColors.lightTextPrimary,
        fontFamily: 'PlusJakartaSans',
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.lightTextPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'PlusJakartaSans',
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'PlusJakartaSans',
    scaffoldBackgroundColor: AppColors.darkBackground,
    extensions: const <ThemeExtension<dynamic>>[MyColors.dark],
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 14,
        color: AppColors.darkTextPrimary,
        fontFamily: 'PlusJakartaSans',
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'PlusJakartaSans',
      ),
    ),
  );
}
