import 'package:dartz/dartz.dart';

import 'package:flutter_planets/core/domain/entities/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class ExecuteActionUseCase<Type, Params> {
  Type call(Params params);
}

class NoParams {}
