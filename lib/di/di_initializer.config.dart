// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker/talker.dart' as _i993;

import '../config/feature_flags.dart' as _i645;
import '../data/network/data_source/launches_network_data_source.dart'
    as _i1037;
import '../data/network/service/launch/launch_service.dart' as _i257;
import '../data/theme_storage.dart' as _i53;
import '../repository/launches_repository.dart' as _i671;
import '../repository/theme_repository.dart' as _i625;
import 'di_app_module.dart' as _i1021;
import 'di_data_module.dart' as _i442;
import 'di_network_module.dart' as _i372;
import 'di_repository_module.dart' as _i8;

extension GetItInjectableX on _i174.GetIt {
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dIAppModule = _$DIAppModule();
    final networkModule = _$NetworkModule();
    final repositoryModule = _$RepositoryModule();
    final dIDataModule = _$DIDataModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => dIAppModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i993.Talker>(() => dIAppModule.provideLogger());
    gh.lazySingleton<_i53.ThemeStorage>(
      () => dIDataModule.provideThemeStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i645.FeatureFlags>(
      () => dIDataModule.provideFeatureFlags(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.provideDio());
    gh.factory<_i625.ThemeRepository>(
      () => repositoryModule.provideThemeRepository(gh<_i53.ThemeStorage>()),
    );
    gh.lazySingleton<_i257.LaunchService>(
      () => networkModule.provideLaunchService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1037.LaunchesDataSource>(
      () => networkModule.provideLaunchesDataSource(gh<_i257.LaunchService>()),
    );
    gh.factory<_i671.LaunchesRepository>(
      () => repositoryModule.provideLaunchesRepository(
        gh<_i1037.LaunchesDataSource>(),
      ),
    );
    return this;
  }
}

class _$DIAppModule extends _i1021.DIAppModule {}

class _$NetworkModule extends _i372.NetworkModule {}

class _$RepositoryModule extends _i8.RepositoryModule {}

class _$DIDataModule extends _i442.DIDataModule {}
