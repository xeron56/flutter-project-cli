import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// Wraps a screen with a thin "You're offline" bar that slides in when the
/// device loses connectivity. Pure UI — interceptors handle the actual
/// network failure path.
class ConnectivityBanner extends StatefulWidget {
  const ConnectivityBanner({super.key, required this.child});

  final Widget child;

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner> {
  late final StreamSubscription<List<ConnectivityResult>> _sub;
  bool _offline = false;

  @override
  void initState() {
    super.initState();
    final connectivity = Connectivity();
    connectivity.checkConnectivity().then(_handle);
    _sub = connectivity.onConnectivityChanged.listen(_handle);
  }

  void _handle(List<ConnectivityResult> results) {
    final offline =
        results.isEmpty || results.every((r) => r == ConnectivityResult.none);
    if (offline != _offline && mounted) {
      setState(() => _offline = offline);
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: widget.child),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _offline
              ? Material(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Icon(Icons.wifi_off, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "You're offline",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
