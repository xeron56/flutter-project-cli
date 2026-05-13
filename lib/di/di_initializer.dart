import 'package:flutter_bloc_app_template/di/di_initializer.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Single entry point for all DI registration. Called from `app_runner.dart`
/// with the active flavor name so per-environment overrides resolve correctly.
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<GetIt> initDI(GetIt getIt, String environment) =>
    getIt.init(environment: environment);
