import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_app_template/app/app.dart';
import 'package:flutter_bloc_app_template/config/app_config.dart';
import 'package:flutter_bloc_app_template/config/environment.dart' as env;
import 'package:flutter_bloc_app_template/di/di_container.dart';
import 'package:flutter_bloc_app_template/di/di_initializer.dart';

/// Boots the app. Every flavor's `main_*.dart` ends with `run()` after
/// initializing the `Environment` singleton.
///
/// All uncaught errors are funneled into `_reportError` — wire your crash
/// reporter (Sentry, Crashlytics) there.
Future<void> run([
  List<DeviceOrientation> orientations = const [DeviceOrientation.portraitUp],
]) async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      _reportError(details.exception, details.stack);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      _reportError(error, stack);
      return true;
    };

    await SystemChrome.setPreferredOrientations(orientations);

    final buildType = env.Environment<AppConfig>.instance().buildType.name;
    await initDI(diContainer, buildType);

    runApp(const App());
  }, _reportError);
}

void _reportError(Object error, StackTrace? stack) {
  if (kDebugMode) {
    debugPrint('Uncaught: $error\n$stack');
    return;
  }
  // Hook your crash reporter here, e.g.
  //   Sentry.captureException(error, stackTrace: stack);
}
