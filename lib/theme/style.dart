import 'package:flutter/material.dart';

/// Brand seed for `ColorScheme.fromSeed`. Change here to rebrand the app.
const Color kBrandSeed = Color(0xFF6750A4);

/// Builds a `ThemeData` pair from a single seed color.
///
/// Material 3 derives the entire palette from one seed, so the only thing
/// most apps need to customize is [kBrandSeed]. Drop in your own
/// `TextTheme` / component overrides on the returned `ThemeData` if you need
/// more control.
class MaterialTheme {
  const MaterialTheme(this.textTheme, {this.seed = kBrandSeed});

  final TextTheme textTheme;
  final Color seed;

  ThemeData light() => _build(Brightness.light);
  ThemeData dark() => _build(Brightness.dark);

  ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        centerTitle: false,
      ),
    );
  }
}
