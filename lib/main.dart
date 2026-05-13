import 'package:flutter_bloc_app_template/app_runner.dart';
import 'package:flutter_bloc_app_template/config/app_config.dart';
import 'package:flutter_bloc_app_template/config/build_type.dart';
import 'package:flutter_bloc_app_template/config/environment.dart';
import 'package:flutter_bloc_app_template/data/network/service/constants.dart';

/// Default entry point. Mirrors `main_dev.dart` and exists so `flutter run`
/// without a `-t` flag still works.
void main(List<String> args) {
  Environment.init(
    buildType: BuildType.debug,
    config: const AppConfig(apiBaseUrl: defaultApiBaseUrl),
  );
  run();
}
