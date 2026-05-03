import 'package:flutter/material.dart';
import 'package:recipe/core/style/colors/app_colors.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.cardBg,
    required this.primary,
    required this.primaryLight,
  });

  final Color? background;
  final Color? surface;
  final Color? textPrimary;
  final Color? textSecondary;
  final Color? border;
  final Color? cardBg;
  final Color? primary;
  final Color? primaryLight;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? cardBg,
    Color? primary,
    Color? primaryLight,
  }) {
    return MyColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      cardBg: cardBg ?? this.cardBg,
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
    covariant ThemeExtension<MyColors>? other,
    double t,
  ) {
    if (other is! MyColors) return this;
    return MyColors(
      background: Color.lerp(background, other.background, t),
      surface: Color.lerp(surface, other.surface, t),
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t),
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t),
      border: Color.lerp(border, other.border, t),
      cardBg: Color.lerp(cardBg, other.cardBg, t),
      primary: Color.lerp(primary, other.primary, t),
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t),
    );
  }

  // ── Light ─────────────────────────────────────
  static const MyColors light = MyColors(
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    border: AppColors.lightBorder,
    cardBg: AppColors.lightCardBg,
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
  );

  // ── Dark ──────────────────────────────────────
  static const MyColors dark = MyColors(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    border: AppColors.darkBorder,
    cardBg: AppColors.darkCardBg,
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
  );
}
