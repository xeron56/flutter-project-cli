import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_app_template/data/failure/failure.exports.dart';
import 'package:flutter_bloc_app_template/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_app_template/models/auth/auth_user.dart';
import 'package:flutter_bloc_app_template/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repo;

  const user = AuthUser(id: '1', email: 'demo@example.com');

  setUp(() {
    repo = _MockAuthRepository();
  });

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'bootstrap emits Authenticated when a session is restored',
      build: () {
        when(repo.restoreSession)
            .thenAnswer((_) async => const Right<Failure, AuthUser?>(user));
        return AuthBloc(repo);
      },
      act: (b) => b.add(const AuthBootstrapRequested()),
      expect: () => [const AuthState.authenticated(user)],
    );

    blocTest<AuthBloc, AuthState>(
      'bootstrap emits Unauthenticated when no token is stored',
      build: () {
        when(repo.restoreSession).thenAnswer(
          (_) async => const Right<Failure, AuthUser?>(null),
        );
        return AuthBloc(repo);
      },
      act: (b) => b.add(const AuthBootstrapRequested()),
      expect: () => [const AuthState.unauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'login emits Authenticated on success',
      build: () {
        when(
          () => repo.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Right<Failure, AuthUser>(user));
        return AuthBloc(repo);
      },
      act: (b) => b.add(
        const AuthLoginRequested(email: 'demo@example.com', password: 'secret'),
      ),
      expect: () => [
        const AuthState.unknown(),
        const AuthState.authenticated(user),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'login emits Unauthenticated with failure on error',
      build: () {
        when(
          () => repo.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async =>
              const Left<Failure, AuthUser>(ValidationFailure(message: 'bad')),
        );
        return AuthBloc(repo);
      },
      act: (b) => b.add(
        const AuthLoginRequested(email: 'x@y.z', password: 'short'),
      ),
      expect: () => [
        const AuthState.unknown(),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.unauthenticated)
            .having((s) => s.failure, 'failure', isA<ValidationFailure>()),
      ],
    );
  });
}
