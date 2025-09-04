import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:flutter_planets/core/domain/entities/exceptions.dart';
import 'package:flutter_planets/core/domain/entities/failure.dart';

/// Class with methods to reuse code in the repository layer
class RepositoryBase<T> {
  /// Generic function that handles exceptions in the repository layer
  /// [call] is the function that will be executed in which the
  /// handle exceptions
  Future<Either<Failure, T>> remoteRequest({
    required FutureOr<Either<Failure, T>> Function() call,
  }) async {
    try {
      return await call();
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ErrorFailure(message: e.message));
    } on HttpException catch (e) {
      return Left(HttpFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
