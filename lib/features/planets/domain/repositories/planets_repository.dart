import 'package:dartz/dartz.dart';

import 'package:flutter_planets/core/domain/entities/failure.dart';
import 'package:flutter_planets/features/planets/domain/entities/planet_entity.dart';

abstract class PlanetsRepository {
  Future<Either<Failure, List<PlanetEntity>>> availablePlanets();
}
