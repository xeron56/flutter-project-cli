import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/app/localization.dart';
import 'package:flutter_bloc_app_template/bloc/theme/theme_cubit.dart';
import 'package:flutter_bloc_app_template/di/app_bloc_providers.dart';
import 'package:flutter_bloc_app_template/di/app_repository_providers.dart';
import 'package:flutter_bloc_app_template/routes/router.dart';
import 'package:flutter_bloc_app_template/theme/style.dart';
import 'package:flutter_bloc_app_template/theme/util.dart';
import 'package:flutter_bloc_app_template/widgets/connectivity_banner.dart';

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

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context: context);
    final theme = MaterialTheme(textTheme);
    final themeMode = context.watch<ThemeCubit>().state.themeMode;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: appSupportedLocales,
      onGenerateTitle: (_) => 'Flutter BLoC Template',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
      builder: (context, child) =>
          ConnectivityBanner(child: child ?? const SizedBox()),
    );
  }
}
