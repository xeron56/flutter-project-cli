import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/bloc/theme/app_theme.dart';
import 'package:flutter_bloc_app_template/bloc/theme/theme_cubit.dart';
import 'package:flutter_bloc_app_template/features/auth/bloc/auth_bloc.dart';

/// Minimal settings: theme selector + sign-out. Add new rows as `ListTile`s
/// — this screen stays intentionally small.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader('Appearance'),
          BlocBuilder<ThemeCubit, AppTheme>(
            builder: (context, theme) => RadioGroup<AppTheme>(
              groupValue: theme,
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeCubit>().setTheme(value);
                }
              },
              child: Column(
                children: [
                  for (final option in AppTheme.values)
                    RadioListTile<AppTheme>(
                      title: Text(_label(option)),
                      value: option,
                    ),
                ],
              ),
            ),
          ),
          const Divider(),
          const _SectionHeader('Account'),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () =>
                context.read<AuthBloc>().add(const AuthLogoutRequested()),
          ),
        ],
      ),
    );
  }

  String _label(AppTheme t) => switch (t) {
        AppTheme.system => 'Follow system',
        AppTheme.light => 'Light',
        AppTheme.dark => 'Dark',
      };
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
