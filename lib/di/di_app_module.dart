import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

@module
abstract class DIAppModule {
  /// Awaited once during `getIt.init` so synchronous consumers downstream
  /// (TokenStorage, ThemeStorage, FeatureFlags) can `get<SharedPreferences>()`
  /// without an `await`.
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  Talker provideLogger() => Talker();
}
