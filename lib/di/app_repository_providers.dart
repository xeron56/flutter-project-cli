import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/repository/auth_repository.dart';
import 'package:flutter_bloc_app_template/repository/launches_repository.dart';
import 'package:provider/single_child_widget.dart' show SingleChildWidget;

import 'di_container.dart';

/// Single source of truth for the `RepositoryProvider`s installed at app root.
/// Add a new repository here when you introduce a new feature slice.
abstract class AppRepositoryProviders {
  static List<SingleChildWidget> providers() {
    return [
      RepositoryProvider<AuthRepository>(
        create: (_) => diContainer.get<AuthRepository>(),
      ),
      RepositoryProvider<LaunchesRepository>(
        create: (_) => diContainer.get<LaunchesRepository>(),
      ),
    ];
  }
}
