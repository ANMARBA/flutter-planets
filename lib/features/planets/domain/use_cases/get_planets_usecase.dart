import 'package:dartz/dartz.dart';

import 'package:flutter_planets/core/domain/entities/failure.dart';
import 'package:flutter_planets/core/domain/usecases/usecase.dart';
import 'package:flutter_planets/features/planets/domain/entities/planet_entity.dart';
import 'package:flutter_planets/features/planets/domain/repositories/planets_repository.dart';

class GetAvailableFieldsUseCase extends UseCase<List<PlanetEntity>, NoParams> {
  final PlanetsRepository _repository;

  GetAvailableFieldsUseCase({
    required PlanetsRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<PlanetEntity>>> call(
    NoParams params,
  ) =>
      _repository.availablePlanets();
}
