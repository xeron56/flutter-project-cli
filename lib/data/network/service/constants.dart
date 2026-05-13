/// Default base url used when an environment doesn't set one.
///
/// Real flavors should pass their own url via `AppConfig.apiBaseUrl` from the
/// matching `main_*.dart` entry point. This default keeps the SpaceX example
/// in `LaunchService` working out of the box.
const String defaultApiBaseUrl = 'https://api.spacexdata.com/v3/';
