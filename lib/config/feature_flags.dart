import 'package:shared_preferences/shared_preferences.dart';

/// Tiny feature-flag abstraction. Reads from (in order):
///   1. `AppConfig.featureFlagsOverride` — static QA overrides per flavor
///   2. `SharedPreferences` — runtime toggles
///   3. defaults passed in [isEnabled]
///
/// Swap the backing store for remote config once a real service is wired in.
class FeatureFlags {
  FeatureFlags({
    required SharedPreferences prefs,
    Map<String, bool> staticOverrides = const {},
  }) : _prefs = prefs,
       _staticOverrides = staticOverrides;

  static const _prefix = 'flag.';

  final SharedPreferences _prefs;
  final Map<String, bool> _staticOverrides;

  bool isEnabled(String key, {bool defaultValue = false}) {
    if (_staticOverrides.containsKey(key)) {
      return _staticOverrides[key]!;
    }
    return _prefs.getBool('$_prefix$key') ?? defaultValue;
  }

  Future<void> setOverride(String key, bool value) =>
      _prefs.setBool('$_prefix$key', value);

  Future<void> clearOverride(String key) => _prefs.remove('$_prefix$key');
}
