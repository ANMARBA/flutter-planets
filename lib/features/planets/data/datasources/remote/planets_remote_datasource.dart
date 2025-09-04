import 'package:flutter_planets/features/planets/data/models/planet_model.dart';

abstract class PlanetsRemoteDataSource {
  Future<List<PlanetModel>> availablePlanets();
}
