import 'package:flutter/material.dart';

/// Brand seed for `ColorScheme.fromSeed`. Change here to rebrand the app.
const Color kBrandSeed = Color(0xFF6B4EFF);

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
      scaffoldBackgroundColor: const Color(0xFFF8F7FB),
      dividerColor: const Color(0xFFEAE5F0),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFF8F7FB),
        foregroundColor: scheme.onSurface,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFEAE5F0)),
        ),
      ),
    );
  }
}
