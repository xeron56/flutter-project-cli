/// Per-flavor configuration injected at startup from `main_*.dart`.
///
/// Anything that varies by environment lives here so the rest of the app can
/// stay flavor-agnostic. Read it via `Environment.instance().config`.
class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    this.sentryDsn,
    this.featureFlagsOverride = const {},
  });

  /// Base url for the primary REST API.
  final String apiBaseUrl;

  /// DSN for the crash reporter. Empty/null means crash reporting is off.
  final String? sentryDsn;

  /// Static feature-flag overrides (useful for QA builds).
  final Map<String, bool> featureFlagsOverride;

  AppConfig copyWith({
    String? apiBaseUrl,
    String? sentryDsn,
    Map<String, bool>? featureFlagsOverride,
  }) =>
      AppConfig(
        apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
        sentryDsn: sentryDsn ?? this.sentryDsn,
        featureFlagsOverride: featureFlagsOverride ?? this.featureFlagsOverride,
      );
}
