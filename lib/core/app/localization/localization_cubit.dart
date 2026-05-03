import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit(this._prefs) : super(const Locale('en')) {
    _loadSavedLanguage();
  }

  final SharedPreferences _prefs;
  static const _key = 'lang_code';

  void _loadSavedLanguage() {
    final langCode = _prefs.getString(_key) ?? 'en';
    emit(Locale(langCode));
  }

  Future<void> toggleLanguage() async {
    final newLang = state.languageCode == 'en' ? 'ar' : 'en';
    await _prefs.setString(_key, newLang);
    emit(Locale(newLang));
  }

  bool get isArabic => state.languageCode == 'ar';
}
