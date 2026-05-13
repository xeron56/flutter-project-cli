import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/features/launch/view/launch_screen.dart';
import 'package:flutter_bloc_app_template/features/main/main_screen.dart';
import 'package:flutter_bloc_app_template/features/settings/view/settings_screen.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const settings = '/settings';
  static const launchDetail = '/launch/:flightNumber';

  static String launchFor(int flightNumber) => '/launch/$flightNumber';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: kDebugMode,
  routes: [
    ShellRoute(
      builder: (_, _, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (_, state) => _fadeTransition(state, _HomeTab()),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (_, state) =>
              _fadeTransition(state, const SettingsScreen()),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.launchDetail,
      builder: (_, state) {
        final raw = state.pathParameters['flightNumber'];
        final flightNumber = int.tryParse(raw ?? '') ?? 1;
        return LaunchScreen(flightNumber: flightNumber);
      },
    ),
  ],
  errorBuilder: (_, state) => _NotFoundScreen(uri: state.uri.toString()),
);

CustomTransitionPage<T> _fadeTransition<T>(
  GoRouterState state,
  Widget child,
) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    );

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          for (var i = 1; i <= 5; i++)
            ListTile(
              title: Text('Launch #$i'),
              subtitle: const Text('Tap to view SpaceX launch details'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(AppRoutes.launchFor(i)),
            ),
        ],
      ),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen({required this.uri});
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not found')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text('No route for "$uri"'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    );
  }
}
