import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_app_template/data/auth/auth_data_source.dart';
import 'package:flutter_bloc_app_template/data/auth/token_storage.dart';
import 'package:flutter_bloc_app_template/data/failure/failure.exports.dart';
import 'package:flutter_bloc_app_template/models/auth/auth_user.dart';

/// Domain-facing auth API. Hides the token lifecycle from the rest of the app
/// — callers ask for `login`, `restoreSession`, or `logout` and get a typed
/// `Result`.
abstract class AuthRepository {
  Future<Result<AuthUser>> login({
    required String email,
    required String password,
  });

  /// Returns `Right(null)` if no session is stored, `Right(user)` if the
  /// stored token is still valid, or `Left(failure)` on a hard error.
  Future<Result<AuthUser?>> restoreSession();

  Future<Result<Unit>> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthDataSource dataSource,
    required TokenStorage tokenStorage,
  })  : _dataSource = dataSource,
        _tokenStorage = tokenStorage;

  final AuthDataSource _dataSource;
  final TokenStorage _tokenStorage;

  @override
  Future<Result<AuthUser>> login({
    required String email,
    required String password,
  }) async {
    final result = await _dataSource.login(email: email, password: password);
    return result.fold(
      (failure) async => Left(failure),
      (success) async {
        await _tokenStorage.writeToken(success.token);
        return Right(success.user);
      },
    );
  }

  @override
  Future<Result<AuthUser?>> restoreSession() async {
    final token = await _tokenStorage.readToken();
    if (token == null || token.isEmpty) {
      return const Right(null);
    }
    final result = await _dataSource.fetchCurrentUser(token);
    return result.fold(
      (failure) async {
        if (failure is UnauthorizedFailure) {
          await _tokenStorage.clear();
          return const Right(null);
        }
        return Left(failure);
      },
      (user) async => Right(user),
    );
  }

  @override
  Future<Result<Unit>> logout() async {
    final token = await _tokenStorage.readToken();
    await _tokenStorage.clear();
    if (token == null) return const Right(unit);
    return _dataSource.logout(token);
  }
}
