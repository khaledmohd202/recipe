// app_localizations.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/core/languages/app_localizations_delegate.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  late Map<String, dynamic> _localizedStrings;

  Future<void> load() async {
    final jsonString = await rootBundle.loadString(
      'lang/${locale.languageCode}.json',
    );
    _localizedStrings = json.decode(jsonString) as Map<String, dynamic>;
  }

  String translate(String key) => _localizedStrings[key]?.toString() ?? key;

  String translateCategory(String categoryName) {
    final categories = _localizedStrings['categories'] as Map?;
    return categories?[categoryName]?.toString() ?? categoryName;
  }

  String translateMeal(String mealName) {
    final meals = _localizedStrings['meals'] as Map?;
    return meals?[mealName]?.toString() ?? mealName;
  }

  bool get isArabic => locale.languageCode == 'ar';
}
