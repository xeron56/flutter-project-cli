import 'package:flutter_bloc_app_template/bloc/theme/app_theme.dart';
import 'package:flutter_bloc_app_template/data/theme_storage.dart';

abstract class ThemeRepository {
  Future<AppTheme> getTheme();
  Future<void> saveTheme(AppTheme theme);
}

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl(this._storage);

  final ThemeStorage _storage;

  @override
  Future<AppTheme> getTheme() => _storage.getTheme();

  @override
  Future<void> saveTheme(AppTheme theme) => _storage.saveTheme(theme);
}
