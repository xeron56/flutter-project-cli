import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_app_template/data/failure/failure.exports.dart';
import 'package:flutter_bloc_app_template/models/auth/auth_user.dart';
import 'package:flutter_bloc_app_template/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Owns the global session state. Listened to by the router (to redirect
/// authenticated/unauthenticated users) and consumed by feature screens that
/// need the current user.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthState.unknown()) {
    on<AuthBootstrapRequested>(_onBootstrap);
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogoutRequested>(_onLogout);
  }

  final AuthRepository _repository;

  Future<void> _onBootstrap(
    AuthBootstrapRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _repository.restoreSession();
    emit(
      result.fold(
        (failure) => AuthState.unauthenticated(failure: failure),
        (user) => user == null
            ? const AuthState.unauthenticated()
            : AuthState.authenticated(user),
      ),
    );
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.unknown());
    final result = await _repository.login(
      email: event.email,
      password: event.password,
    );
    emit(
      result.fold(
        (failure) => AuthState.unauthenticated(failure: failure),
        (user) => AuthState.authenticated(user),
      ),
    );
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.logout();
    emit(const AuthState.unauthenticated());
  }
}
