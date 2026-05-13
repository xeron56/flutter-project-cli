import 'package:dio/dio.dart';
import 'package:flutter_bloc_app_template/data/auth/token_storage.dart';

/// Attaches the current bearer token (if any) to every outgoing request.
///
/// On a 401 the interceptor clears the stored token so the auth bloc — which
/// listens to the token stream — can transition to `Unauthenticated`.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _tokenStorage.clear();
    }
    handler.next(err);
  }
}
