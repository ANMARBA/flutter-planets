import 'dart:convert';

import 'package:flutter_planets/core/data/datasources/datasource_base.dart';
import 'package:flutter_planets/core/shared/server/server_api_client.dart';
import 'package:flutter_planets/features/planets/data/datasources/remote/planets_remote_datasource.dart';
import 'package:flutter_planets/features/planets/data/datasources/routes/planets_routes.dart';
import 'package:flutter_planets/features/planets/data/models/planet_model.dart';

/// Implementation of [PlanetsRemoteDataSource]
class PlanetsRemoteDataSourceImpl implements PlanetsRemoteDataSource {
  final ServerApiClient _apiClient;

  PlanetsRemoteDataSourceImpl({
    required ServerApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<PlanetModel>> availablePlanets() {
    return DataSourceBase<List<PlanetModel>>().serverRequest(
      call: () async {
        final request = await _apiClient.get(PlanetsRoutes.availablePlanets);

        final data = json.decode(request.body)['data'] as List;

        final planets = data
            .map<PlanetModel>(
              (res) => PlanetModel.fromJson(res as Map<String, dynamic>),
            )
            .toList();

        return planets;
      },
    );
  }
}
