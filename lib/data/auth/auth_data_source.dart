import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_app_template/data/failure/failure.exports.dart';
import 'package:flutter_bloc_app_template/models/auth/auth_user.dart';

/// Contract for the auth backend. Swap [MockAuthDataSource] for a Dio-backed
/// implementation once a real endpoint exists — the rest of the app shouldn't
/// need to change.
abstract class AuthDataSource {
  Future<Result<({String token, AuthUser user})>> login({
    required String email,
    required String password,
  });

  Future<Result<AuthUser>> fetchCurrentUser(String token);

  Future<Result<Unit>> logout(String token);
}

/// In-memory stub that accepts any well-formed email and a >= 6-char password.
///
/// Keeps the template runnable without a real auth backend. Replace with a
/// retrofit service when wiring up a real API.
class MockAuthDataSource implements AuthDataSource {
  @override
  Future<Result<({String token, AuthUser user})>> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!email.contains('@') || password.length < 6) {
      return const Left(
        ValidationFailure(message: 'Invalid email or password'),
      );
    }
    final user = AuthUser(
      id: email.hashCode.toString(),
      email: email,
      displayName: email.split('@').first,
    );
    return Right((token: 'mock-token-${user.id}', user: user));
  }

  @override
  Future<Result<AuthUser>> fetchCurrentUser(String token) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (!token.startsWith('mock-token-')) {
      return const Left(UnauthorizedFailure());
    }
    final id = token.replaceFirst('mock-token-', '');
    return Right(AuthUser(id: id, email: 'demo@example.com'));
  }

  @override
  Future<Result<Unit>> logout(String token) async {
    return const Right(unit);
  }
}
