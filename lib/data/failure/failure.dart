import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Sealed hierarchy of every error the data layer can produce.
///
/// Repositories return `Future<Result<T>>`; blocs pattern-match on the
/// `Failure` subtypes to drive UI state. Always extend this class for new
/// error categories instead of throwing exceptions across layer boundaries.
sealed class Failure extends Equatable {
  const Failure({this.message, this.cause});

  final String? message;
  final Object? cause;

  @override
  List<Object?> get props => [runtimeType, message];
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection', super.cause});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'Request timed out', super.cause});
}

class ServerFailure extends Failure {
  const ServerFailure({
    this.statusCode,
    super.message = 'Server error',
    super.cause,
  });

  final int? statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Unauthorized', super.cause});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Not found', super.cause});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error', super.cause});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required String super.message, super.cause});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Something went wrong', super.cause});
}

/// Convenience alias used across the app.
typedef Result<T> = Either<Failure, T>;
