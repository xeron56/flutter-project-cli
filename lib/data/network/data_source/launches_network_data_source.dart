import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_app_template/data/failure/failure.exports.dart';
import 'package:flutter_bloc_app_template/data/network/model/launch/full/network_launch_full_model.dart';
import 'package:flutter_bloc_app_template/data/network/model/launch/network_launch_model.dart';
import 'package:flutter_bloc_app_template/data/network/service/launch/launch_service.dart';

/// Network-side contract for launches. Lives at the boundary of the data
/// layer — wraps the raw retrofit service and converts thrown errors into a
/// typed `Failure`. Repositories consume this and map to domain resources.
abstract class LaunchesDataSource {
  Future<Result<List<NetworkLaunchModel>>> getLaunches({
    bool? hasId = true,
    int? limit,
    int? offset,
    int? launchYear,
    int? launchSuccess,
    String? order,
  });

  Future<Result<NetworkLaunchFullModel>> getLaunch(int flightNumber);
}

class LaunchesNetworkDataSource implements LaunchesDataSource {
  LaunchesNetworkDataSource(this._service);

  final LaunchService _service;

  @override
  Future<Result<List<NetworkLaunchModel>>> getLaunches({
    bool? hasId = true,
    int? limit,
    int? offset,
    int? launchYear,
    int? launchSuccess,
    String? order,
  }) async {
    try {
      final list = await _service.fetchLaunches(
        hasId: hasId,
        limit: limit,
        offset: offset,
        launchYear: launchYear,
        launchSuccess: launchSuccess,
        order: order,
      );
      return Right(list);
    } catch (e, st) {
      return Left(mapErrorToFailure(e, st));
    }
  }

  @override
  Future<Result<NetworkLaunchFullModel>> getLaunch(int flightNumber) async {
    try {
      final result = await _service.fetchLaunch(flightNumber);
      return Right(result);
    } catch (e, st) {
      return Left(mapErrorToFailure(e, st));
    }
  }
}
