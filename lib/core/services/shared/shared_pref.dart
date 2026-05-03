import 'package:recipe/core/services/shared/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppPrefs {
  AppPrefs(this._prefs);
  final SharedPreferences _prefs;

  // ── Theme ─────────────────────────────────────
  bool get isDark => _prefs.getBool(PrefKeys.themeMode) ?? false;
  Future<void> setDark(bool val) => _prefs.setBool(PrefKeys.themeMode, val);

  // ── Language ──────────────────────────────────
  String get langCode => _prefs.getString(PrefKeys.language) ?? 'en';
  Future<void> setLangCode(String val) =>
      _prefs.setString(PrefKeys.language, val);

  // ── Token ─────────────────────────────────────
  String? get token => _prefs.getString(PrefKeys.accessToken);
  Future<void> setToken(String val) =>
      _prefs.setString(PrefKeys.accessToken, val);
  Future<void> clearToken() => _prefs.remove(PrefKeys.accessToken);

  // ── User ──────────────────────────────────────
  String? get userId => _prefs.getString(PrefKeys.userId);
  Future<void> setUserId(String val) => _prefs.setString(PrefKeys.userId, val);

  String? get userRole => _prefs.getString(PrefKeys.userRole);
  Future<void> setUserRole(String val) =>
      _prefs.setString(PrefKeys.userRole, val);

  // ── Onboarding ────────────────────────────────
  bool get onboardingDone => _prefs.getBool(PrefKeys.onboarding) ?? false;
  Future<void> setOnboardingDone() => _prefs.setBool(PrefKeys.onboarding, true);

  // ── Generic ───────────────────────────────────
  T? get<T>(String key) {
    return switch (T) {
      const (String) => _prefs.getString(key) as T?,
      const (int) => _prefs.getInt(key) as T?,
      const (double) => _prefs.getDouble(key) as T?,
      const (bool) => _prefs.getBool(key) as T?,
      _ => null,
    };
  }

  Future<void> set<T>(String key, T value) async {
    switch (value) {
      case final String v:
        await _prefs.setString(key, v);
      case final int v:
        await _prefs.setInt(key, v);
      case final double v:
        await _prefs.setDouble(key, v);
      case final bool v:
        await _prefs.setBool(key, v);
    }
  }

  // ── Utilities ─────────────────────────────────
  Future<void> remove(String key) => _prefs.remove(key);
  bool hasKey(String key) => _prefs.containsKey(key);
  Future<void> clearAll() => _prefs.clear();
}
