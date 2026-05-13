import 'package:flutter_bloc_app_template/data/auth/auth_data_source.dart';
import 'package:flutter_bloc_app_template/data/auth/token_storage.dart';
import 'package:flutter_bloc_app_template/data/network/data_source/launches_network_data_source.dart';
import 'package:flutter_bloc_app_template/data/theme_storage.dart';
import 'package:flutter_bloc_app_template/repository/auth_repository.dart';
import 'package:flutter_bloc_app_template/repository/launches_repository.dart';
import 'package:flutter_bloc_app_template/repository/theme_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RepositoryModule {
  @lazySingleton
  AuthDataSource provideAuthDataSource() => MockAuthDataSource();

  @lazySingleton
  AuthRepository provideAuthRepository(
    AuthDataSource dataSource,
    TokenStorage tokenStorage,
  ) =>
      AuthRepositoryImpl(dataSource: dataSource, tokenStorage: tokenStorage);

  @factoryMethod
  ThemeRepository provideThemeRepository(ThemeStorage themeStorage) =>
      ThemeRepositoryImpl(themeStorage);

  @factoryMethod
  LaunchesRepository provideLaunchesRepository(LaunchesDataSource dataSource) =>
      LaunchesRepositoryImpl(dataSource);
}
