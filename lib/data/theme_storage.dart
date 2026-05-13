import 'package:flutter_bloc_app_template/bloc/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeStorage {
  Future<AppTheme> getTheme();
  Future<void> saveTheme(AppTheme theme);
}

class SharedPreferencesThemeStorage implements ThemeStorage {
  SharedPreferencesThemeStorage(this._prefs);

  static const _themeKey = 'app_theme';

  final SharedPreferences _prefs;

  @override
  Future<AppTheme> getTheme() async {
    final idx = _prefs.getInt(_themeKey) ?? AppTheme.system.index;
    return AppTheme.values[idx.clamp(0, AppTheme.values.length - 1)];
  }

  @override
  Future<void> saveTheme(AppTheme theme) async {
    await _prefs.setInt(_themeKey, theme.index);
  }
}
