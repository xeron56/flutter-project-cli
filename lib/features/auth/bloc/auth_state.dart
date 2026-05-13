part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.failure,
  });

  const AuthState.unknown() : this();
  const AuthState.authenticated(AuthUser user)
      : this(status: AuthStatus.authenticated, user: user);
  const AuthState.unauthenticated({Failure? failure})
      : this(status: AuthStatus.unauthenticated, failure: failure);

  final AuthStatus status;
  final AuthUser? user;
  final Failure? failure;

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isResolved => status != AuthStatus.unknown;

  @override
  List<Object?> get props => [status, user, failure];
}
