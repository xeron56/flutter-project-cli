import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/bloc/theme/app_theme.dart';
import 'package:flutter_bloc_app_template/bloc/theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (context, theme) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Appearance',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            RadioGroup<AppTheme>(
              groupValue: theme,
              onChanged: (value) {
                if (value != null) context.read<ThemeCubit>().setTheme(value);
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
          ],
        ),
      ),
    );
  }

  String _label(AppTheme t) => switch (t) {
        AppTheme.system => 'Follow system',
        AppTheme.light => 'Light',
        AppTheme.dark => 'Dark',
      };
}
