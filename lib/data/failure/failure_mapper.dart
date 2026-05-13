import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_app_template/data/failure/failure.dart';

/// Converts any thrown error into a typed [Failure].
///
/// Call this in data sources `catch` blocks so the rest of the app never has
/// to think about Dio internals.
Failure mapErrorToFailure(Object error, [StackTrace? stack]) {
  if (error is Failure) return error;

  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(cause: error);
      case DioExceptionType.connectionError:
        return NetworkFailure(cause: error);
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NetworkFailure(cause: error);
        }
        return UnknownFailure(message: error.message, cause: error);
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        if (code == 401 || code == 403) {
          return UnauthorizedFailure(cause: error);
        }
        if (code == 404) {
          return NotFoundFailure(cause: error);
        }
        return ServerFailure(
          statusCode: code,
          message: error.response?.statusMessage ?? 'Server error',
          cause: error,
        );
    }
  }

  if (error is SocketException) {
    return NetworkFailure(cause: error);
  }

  return UnknownFailure(message: error.toString(), cause: error);
}
