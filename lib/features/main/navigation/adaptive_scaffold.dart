import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/features/main/main_screen.dart';

/// Renders a bottom `NavigationBar` on phone-width layouts and a side
/// `NavigationRail` on tablet/desktop widths.
///
/// Single breakpoint at 720dp — Material 3 guidance. Tweak if your app has a
/// reason to prefer something else.
class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    required this.destinations,
    required this.currentIndex,
    required this.onSelected,
    required this.body,
  });

  final List<ShellDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onSelected;
  final Widget body;

  static const breakpoint = 720.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= breakpoint;
        if (isWide) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: currentIndex,
                  onDestinationSelected: onSelected,
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final d in destinations)
                      NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: Text(d.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            ),
          );
        }
        return Scaffold(
          body: body,
          bottomNavigationBar: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: onSelected,
            destinations: [
              for (final d in destinations)
                NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: d.label,
                ),
            ],
          ),
        );
      },
    );
  }
}
