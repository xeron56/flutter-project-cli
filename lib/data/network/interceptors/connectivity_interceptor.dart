import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

/// Short-circuits requests when the device is fully offline so the app fails
/// fast with a `NetworkFailure` instead of waiting for a socket timeout.
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final results = await _connectivity.checkConnectivity();
    final offline = results.isEmpty ||
        results.every((r) => r == ConnectivityResult.none);
    if (offline) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No internet connection',
        ),
      );
    }
    handler.next(options);
  }
}
