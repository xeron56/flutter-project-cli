import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_app_template/bloc/theme/app_theme.dart';
import 'package:flutter_bloc_app_template/repository/theme_repository.dart';

/// Owns the user's theme preference and persists changes through
/// [ThemeRepository]. Listened to by `App` to flip `MaterialApp.themeMode`.
class ThemeCubit extends Cubit<AppTheme> {
  ThemeCubit(this._repository) : super(AppTheme.system);

  final ThemeRepository _repository;

  Future<void> loadTheme() async {
    emit(await _repository.getTheme());
  }

  Future<void> setTheme(AppTheme theme) async {
    emit(theme);
    await _repository.saveTheme(theme);
  }
}
