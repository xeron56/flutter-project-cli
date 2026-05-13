import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/features/assistant_ui/assistant_ui.dart';
import 'package:flutter_bloc_app_template/features/assistant_ui/primary_screens.dart';
import 'package:flutter_bloc_app_template/features/launch/view/launch_screen.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const chat = '/chat';
  static const goals = '/goals';
  static const email = '/email';
  static const automations = '/automations';
  static const more = '/more';
  static const family = '/family';
  static const finance = '/finance';
  static const calendar = '/calendar';
  static const wellness = '/wellness';
  static const vault = '/vault';
  static const launchDetail = '/launch/:flightNumber';

  static String launchFor(int flightNumber) => '/launch/$flightNumber';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const AssistantHomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.chat,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const AssistantChatScreen()),
    ),
    GoRoute(
      path: AppRoutes.goals,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const AssistantGoalsScreen()),
    ),
    GoRoute(
      path: AppRoutes.email,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const AssistantDocsEmailScreen()),
    ),
    GoRoute(
      path: AppRoutes.automations,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const AssistantAutomationScreen()),
    ),
    GoRoute(
      path: AppRoutes.more,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const AssistantMoreScreen()),
    ),
    GoRoute(
      path: AppRoutes.family,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const FamilyRelationshipsScreen()),
    ),
    GoRoute(
      path: AppRoutes.finance,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const FinanceInsightsScreen()),
    ),
    GoRoute(
      path: AppRoutes.calendar,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const CalendarPlannerScreen()),
    ),
    GoRoute(
      path: AppRoutes.wellness,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const HealthWellnessScreen()),
    ),
    GoRoute(
      path: AppRoutes.vault,
      pageBuilder: (_, state) =>
          _fadeTransition(state, const PrivacyVaultScreen()),
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
