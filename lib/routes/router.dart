import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/features/home/view/home_screen.dart';
import 'package:flutter_bloc_app_template/features/settings/view/settings_screen.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const settings = '/settings';
}

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (_, state) => _fadeTransition(state, const HomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (_, state) => _fadeTransition(state, const SettingsScreen()),
    ),
  ],
  errorBuilder: (_, state) => _NotFoundScreen(uri: state.uri.toString()),
);

CustomTransitionPage<T> _fadeTransition<T>(GoRouterState state, Widget child) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    );

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
