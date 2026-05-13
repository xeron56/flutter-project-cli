import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_app_template/data/failure/failure.exports.dart';
import 'package:flutter_bloc_app_template/models/launch/launch_full_resource.dart';
import 'package:flutter_bloc_app_template/repository/launches_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch_bloc.freezed.dart';
part 'launch_event.dart';
part 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc(this._repository) : super(const LaunchState.loading()) {
    on<LaunchLoadEvent>(_onLoad);
  }

  final LaunchesRepository _repository;

  Future<void> _onLoad(
    LaunchLoadEvent event,
    Emitter<LaunchState> emit,
  ) async {
    emit(const LaunchState.loading());
    final result = await _repository.getLaunch(event.flightNumber);
    emit(
      result.fold(
        (failure) => LaunchState.error(failure: failure),
        (launch) => LaunchState.success(launch: launch),
      ),
    );
  }
}
