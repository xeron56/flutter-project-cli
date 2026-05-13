import 'package:flutter_bloc_app_template/data/network/data_source/launches_network_data_source.dart';
import 'package:flutter_bloc_app_template/index.dart';

/// Domain-facing contract. Returns `Result<T>` so callers (blocs) can pattern
/// match instead of catching exceptions. Network models are converted to the
/// domain `*Resource` types here so the UI never sees `network_*` shapes.
abstract class LaunchesRepository {
  Future<Result<List<LaunchResource>>> getLaunches({
    bool? hasId = true,
    int? limit,
    int? offset,
    int? launchYear,
    int? launchSuccess,
    String? order,
  });

  Future<Result<LaunchFullResource>> getLaunch(int flightNumber);
}

class LaunchesRepositoryImpl implements LaunchesRepository {
  LaunchesRepositoryImpl(this._launchesDataSource);

  final LaunchesDataSource _launchesDataSource;

  @override
  Future<Result<List<LaunchResource>>> getLaunches({
    bool? hasId = true,
    int? limit,
    int? offset,
    int? launchYear,
    int? launchSuccess,
    String? order,
  }) async {
    final result = await _launchesDataSource.getLaunches(
      hasId: hasId,
      limit: limit,
      offset: offset,
      launchYear: launchYear,
      launchSuccess: launchSuccess,
      order: order,
    );
    return result.map((list) => list.map((e) => e.toResource()).toList());
  }

  @override
  Future<Result<LaunchFullResource>> getLaunch(int flightNumber) async {
    final result = await _launchesDataSource.getLaunch(flightNumber);
    return result.map((model) => model.toResource());
  }
}
