import 'dart:async';

import 'package:dio/dio.dart';

/// Retries idempotent (`GET`) requests on transient network errors.
///
/// Keep this lightweight on purpose — for anything more sophisticated swap in
/// `dio_smart_retry`.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required Dio dio,
    this.maxRetries = 2,
    this.retryDelay = const Duration(milliseconds: 400),
  }) : _dio = dio;

  final Dio _dio;
  final int maxRetries;
  final Duration retryDelay;

  static const _retryCountKey = '_retryCount';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final method = options.method.toUpperCase();
    final isIdempotent = method == 'GET' || method == 'HEAD';
    final retryCount = (options.extra[_retryCountKey] as int?) ?? 0;

    final shouldRetry =
        isIdempotent && retryCount < maxRetries && _isTransient(err);

    if (!shouldRetry) {
      return handler.next(err);
    }

    options.extra[_retryCountKey] = retryCount + 1;
    await Future<void>.delayed(retryDelay * (retryCount + 1));

    try {
      final response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _isTransient(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final code = err.response?.statusCode ?? 0;
        return code >= 500 && code < 600;
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return false;
    }
  }
}
