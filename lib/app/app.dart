import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/app/localization.dart';
import 'package:flutter_bloc_app_template/bloc/theme/theme_cubit.dart';
import 'package:flutter_bloc_app_template/di/app_bloc_providers.dart';
import 'package:flutter_bloc_app_template/di/app_repository_providers.dart';
import 'package:flutter_bloc_app_template/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_app_template/routes/router.dart';
import 'package:flutter_bloc_app_template/theme/style.dart';
import 'package:flutter_bloc_app_template/theme/util.dart';
import 'package:flutter_bloc_app_template/widgets/connectivity_banner.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: AppRepositoryProviders.providers(),
        child: MultiBlocProvider(
          providers: AppBlocProviders.providers(),
          child: const _AppView(),
        ),
      );
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late final GoRouterAdapter _routerAdapter;

  @override
  void initState() {
    super.initState();
    _routerAdapter = GoRouterAdapter(context.read<AuthBloc>());
  }

  @override
  void dispose() {
    _routerAdapter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context: context);
    final theme = MaterialTheme(textTheme);
    final themeMode = context.watch<ThemeCubit>().state.themeMode;

    return MaterialApp.router(
      debugShowCheckedModeBanner: kDebugMode,
      restorationScopeId: 'app',
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: appSupportedLocales,
      onGenerateTitle: (_) => 'Flutter BLoC Template',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: themeMode,
      routerConfig: _routerAdapter.router,
      builder: (context, child) =>
          ConnectivityBanner(child: child ?? const SizedBox()),
    );
  }
}

/// Thin holder so the router survives `setState` and disposes its
/// `refreshListenable` when the app tears down.
class GoRouterAdapter {
  GoRouterAdapter(AuthBloc authBloc) : router = buildRouter(authBloc);

  final GoRouter router;

  void dispose() => router.dispose();
}
