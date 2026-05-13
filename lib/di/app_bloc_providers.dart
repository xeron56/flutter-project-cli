import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/bloc/theme/theme_cubit.dart';
import 'package:flutter_bloc_app_template/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_app_template/repository/auth_repository.dart';
import 'package:flutter_bloc_app_template/repository/theme_repository.dart';
import 'package:provider/single_child_widget.dart' show SingleChildWidget;

import 'di_container.dart';

/// App-scoped blocs/cubits. Feature-scoped ones (like `LaunchBloc`) belong in
/// the screen that owns them, not here.
abstract class AppBlocProviders {
  static List<SingleChildWidget> providers() {
    return [
      BlocProvider(
        create: (_) =>
            ThemeCubit(diContainer.get<ThemeRepository>())..loadTheme(),
      ),
      BlocProvider(
        create: (_) => AuthBloc(diContainer.get<AuthRepository>())
          ..add(const AuthBootstrapRequested()),
      ),
    ];
  }
}
