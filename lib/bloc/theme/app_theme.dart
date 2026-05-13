import 'package:flutter/material.dart';

/// Single source of truth for the user's theme preference.
///
/// Maps 1:1 onto Flutter's [ThemeMode]. Persisted via `ThemeStorage`.
enum AppTheme {
  system,
  light,
  dark;

  ThemeMode get themeMode => switch (this) {
        AppTheme.system => ThemeMode.system,
        AppTheme.light => ThemeMode.light,
        AppTheme.dark => ThemeMode.dark,
      };
}
