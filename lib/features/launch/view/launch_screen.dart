import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_template/features/launch/bloc/launch_bloc.dart';
import 'package:flutter_bloc_app_template/repository/launches_repository.dart';
import 'package:flutter_bloc_app_template/widgets/widgets.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key, required this.flightNumber});

  final int flightNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LaunchBloc(
        RepositoryProvider.of<LaunchesRepository>(context),
      )..add(LaunchLoadEvent(flightNumber: flightNumber)),
      child: _LaunchView(flightNumber: flightNumber),
    );
  }
}

class _LaunchView extends StatelessWidget {
  const _LaunchView({required this.flightNumber});

  final int flightNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      builder: (context, state) {
        if (state is LaunchLoadingState) {
          return Scaffold(appBar: AppBar(), body: const LoadingContent());
        }
        if (state is LaunchErrorState) {
          return Scaffold(
            appBar: AppBar(title: Text(state.failure.message ?? 'Error')),
            body: ErrorContent(
              onTryAgainClick: () => context
                  .read<LaunchBloc>()
                  .add(LaunchLoadEvent(flightNumber: flightNumber)),
            ),
          );
        }
        if (state is LaunchSuccessState) {
          return _LaunchContent(launch: state);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _LaunchContent extends StatelessWidget {
  const _LaunchContent({required this.launch});

  final LaunchSuccessState launch;

  @override
  Widget build(BuildContext context) {
    final resource = launch.launch;
    return Scaffold(
      appBar: AppBar(title: Text(resource.missionName ?? 'Launch')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoRow(label: 'Flight', value: '#${resource.flightNumber}'),
          _InfoRow(
            label: 'Result',
            value: (resource.launchSuccess ?? false) ? 'Success' : 'Failed',
          ),
          if (resource.details != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(resource.details!),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
