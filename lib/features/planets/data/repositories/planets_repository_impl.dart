import 'package:dartz/dartz.dart';

import 'package:flutter_planets/core/domain/entities/failure.dart';
import 'package:flutter_planets/core/domain/repositories/repository_base.dart';
import 'package:flutter_planets/features/planets/data/datasources/remote/planets_remote_datasource.dart';
import 'package:flutter_planets/features/planets/domain/entities/planet_entity.dart';
import 'package:flutter_planets/features/planets/domain/repositories/planets_repository.dart';

/// Implementation of [PlanetsRepository]
class PlanetsRepositoryImpl implements PlanetsRepository {
  final PlanetsRemoteDataSource _remoteDataSource;

  PlanetsRepositoryImpl({
    required PlanetsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<PlanetEntity>>> availablePlanets() {
    return RepositoryBase<List<PlanetEntity>>().remoteRequest(
      call: () async {
        final models = await _remoteDataSource.availablePlanets();

        final entities = models.map((m) => m.toEntity()).toList();

        return Right(entities);
      },
    );
  }
}
