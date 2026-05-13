import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/repository/launches_repository.dart';
import 'package:provider/single_child_widget.dart' show SingleChildWidget;

import 'di_container.dart';

abstract class AppRepositoryProviders {
  static List<SingleChildWidget> providers() {
    return [
      RepositoryProvider<LaunchesRepository>(
        create: (_) => diContainer.get<LaunchesRepository>(),
      ),
    ];
  }
}
