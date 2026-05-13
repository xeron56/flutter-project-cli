import 'package:flutter/widgets.dart';

/// Hook to react to app foreground/background transitions.
///
/// Wire it once near the top of the tree. Features (auth refresh, analytics,
/// cache TTL) subscribe via the passed callbacks.
class AppLifecycleScope extends StatefulWidget {
  const AppLifecycleScope({
    super.key,
    required this.child,
    this.onResume,
    this.onPause,
  });

  final Widget child;
  final VoidCallback? onResume;
  final VoidCallback? onPause;

  @override
  State<AppLifecycleScope> createState() => _AppLifecycleScopeState();
}

class _AppLifecycleScopeState extends State<AppLifecycleScope> {
  AppLifecycleListener? _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onResume: widget.onResume,
      onPause: widget.onPause,
    );
  }

  @override
  void dispose() {
    _listener?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
