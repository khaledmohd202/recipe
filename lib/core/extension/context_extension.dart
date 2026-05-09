import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/core/languages/app_localizations.dart';
import 'package:recipe/core/style/theme/colors_extension.dart';

extension ContextExtension on BuildContext {
  // Navigation Extensions.
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) => Navigator.of(
    this,
  ).pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);

  void pop([dynamic result]) => Navigator.of(this).pop(result);

  void safePop([dynamic result]) {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop(result);
    } else {
      SystemNavigator.pop();
    }
  }

  // Theme Extensions.
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  MyColors get appColors => Theme.of(this).extension<MyColors>()!;

  // Localization Extensions.
  AppLocalizations get localization => AppLocalizations.of(this)!;
  String transl(String key) => localization.translate(key);
  bool get isArabic => localization.isArabic;

  // Screen Size Extensions.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  // Keyboard Extensions.
  void hideKeyboard() => FocusScope.of(this).unfocus();
}
