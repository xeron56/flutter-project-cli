import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/features/main/navigation/adaptive_scaffold.dart';
import 'package:flutter_bloc_app_template/routes/router.dart';
import 'package:go_router/go_router.dart';

/// Hosts the bottom-nav / nav-rail shell. Receives the active tab content as
/// `child` from `go_router`'s `ShellRoute`.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final destinations = buildShellDestinations();
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex =
        destinations.indexWhere((d) => location.startsWith(d.route));

    return AdaptiveScaffold(
      destinations: destinations,
      currentIndex: currentIndex < 0 ? 0 : currentIndex,
      onSelected: (i) => context.go(destinations[i].route),
      body: child,
    );
  }
}

/// Routed destinations rendered inside `MainScreen`.
class ShellDestination {
  const ShellDestination({
    required this.route,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final String route;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

List<ShellDestination> buildShellDestinations() => const [
      ShellDestination(
        route: AppRoutes.home,
        icon: Icons.rocket_launch_outlined,
        selectedIcon: Icons.rocket_launch,
        label: 'Home',
      ),
      ShellDestination(
        route: AppRoutes.settings,
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: 'Settings',
      ),
    ];
