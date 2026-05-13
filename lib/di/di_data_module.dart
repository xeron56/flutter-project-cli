import 'package:flutter_bloc_app_template/config/app_config.dart';
import 'package:flutter_bloc_app_template/config/environment.dart' as env;
import 'package:flutter_bloc_app_template/config/feature_flags.dart';
import 'package:flutter_bloc_app_template/data/theme_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DIDataModule {
  @lazySingleton
  ThemeStorage provideThemeStorage(SharedPreferences prefs) =>
      SharedPreferencesThemeStorage(prefs);

  @lazySingleton
  FeatureFlags provideFeatureFlags(SharedPreferences prefs) {
    final config = env.Environment<AppConfig>.instance().config;
    return FeatureFlags(
      prefs: prefs,
      staticOverrides: config.featureFlagsOverride,
    );
  }
}
