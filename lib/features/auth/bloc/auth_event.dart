part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Fired once at startup so the bloc can check secure storage for an existing
/// token and emit either `Authenticated` or `Unauthenticated`.
class AuthBootstrapRequested extends AuthEvent {
  const AuthBootstrapRequested();
}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
