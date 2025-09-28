import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/index.dart';

import 'package:flutter_bloc_app_template/features/launch/launch_screen.dart';
// import removed: settings_screen.dart (already provided by index.dart)

List<NavDestination> getDestinations(BuildContext context) {
  return [
    NavDestination(
      label: 'Launch',
      icon: const Icon(Icons.rocket_launch_outlined),
      selectedIcon: const Icon(Icons.rocket_launch),
      screen: const LaunchScreen(),
      key: const Key('launch'),
    ),
    NavDestination(
      label: 'Settings',
      icon: const Icon(Icons.settings_outlined),
      selectedIcon: const Icon(Icons.settings),
      screen: const SettingsScreen(),
      key: const Key('settings'),
    ),
  ];
}

List<NavigationDestination> getNavDestinations(BuildContext context) {
  return getDestinations(context)
      .map((e) => NavigationDestination(
            key: e.key,
            icon: e.icon,
            selectedIcon: e.selectedIcon,
            label: e.label,
          ))
      .toList();
}

Widget getScreenByIndex(BuildContext context, int idx) {
  return getDestinations(context)[idx].screen;
}
