import 'package:dio/dio.dart';
import 'package:flutter_bloc_app_template/config/app_config.dart';
import 'package:flutter_bloc_app_template/config/environment.dart' as env;
import 'package:flutter_bloc_app_template/data/auth/token_storage.dart';
import 'package:flutter_bloc_app_template/data/network/data_source/launches_network_data_source.dart';
import 'package:flutter_bloc_app_template/data/network/interceptors/auth_interceptor.dart';
import 'package:flutter_bloc_app_template/data/network/interceptors/connectivity_interceptor.dart';
import 'package:flutter_bloc_app_template/data/network/interceptors/retry_interceptor.dart';
import 'package:flutter_bloc_app_template/data/network/service/launch/launch_service.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  TokenStorage provideTokenStorage() => SecureTokenStorage();

  @lazySingleton
  Dio provideDio(TokenStorage tokenStorage) {
    final config = env.Environment<AppConfig>.instance().config;
    final dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.addAll([
      ConnectivityInterceptor(),
      AuthInterceptor(tokenStorage),
      RetryInterceptor(dio: dio),
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    ]);

    return dio;
  }

  @lazySingleton
  LaunchService provideLaunchService(Dio dio) => LaunchService(dio);

  @lazySingleton
  LaunchesDataSource provideLaunchesDataSource(LaunchService service) =>
      LaunchesNetworkDataSource(service);
}
