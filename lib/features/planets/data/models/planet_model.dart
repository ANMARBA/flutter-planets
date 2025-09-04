import 'package:flutter/foundation.dart';

import 'package:flutter_planets/features/planets/domain/entities/planet_entity.dart';

@immutable
class PlanetModel extends PlanetEntity {
  const PlanetModel({
    required super.name,
    required super.orbitalDistanceKm,
    required super.equatorialRadiusKm,
    required super.volumeKm3,
    required super.massKg,
    required super.densityGCm3,
    required super.surfaceGravityMS2,
    required super.escapeVelocityKmh,
    required super.dayLengthEarthDays,
    required super.yearLengthEarthDays,
    required super.orbitalSpeedKmh,
    required super.atmosphereComposition,
    required super.moons,
    required super.image,
    required super.description,
  });

  factory PlanetModel.fromJson(Map<String, dynamic> json) => PlanetModel(
        name: json['name'] as String,
        orbitalDistanceKm: (json['orbital_distance_km'] as num).toInt(),
        equatorialRadiusKm: (json['equatorial_radius_km'] as num).toInt(),
        volumeKm3: json['volume_km3'],
        massKg: json['mass_kg'] as String,
        densityGCm3: (json['density_g_cm3'] as num).toDouble(),
        surfaceGravityMS2: (json['surface_gravity_m_s2'] as num).toDouble(),
        escapeVelocityKmh: (json['escape_velocity_kmh'] as num).toInt(),
        dayLengthEarthDays: (json['day_length_earth_days'] as num).toDouble(),
        yearLengthEarthDays: json['year_length_earth_days'] != null
            ? (json['year_length_earth_days'] as num).toDouble()
            : null,
        orbitalSpeedKmh: (json['orbital_speed_kmh'] as num).toInt(),
        atmosphereComposition: json['atmosphere_composition'] as String? ?? '',
        moons: (json['moons'] as num).toInt(),
        image: json['image'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );

  PlanetEntity toEntity() => PlanetEntity(
        name: name,
        orbitalDistanceKm: orbitalDistanceKm,
        equatorialRadiusKm: equatorialRadiusKm,
        volumeKm3: volumeKm3,
        massKg: massKg,
        densityGCm3: densityGCm3,
        surfaceGravityMS2: surfaceGravityMS2,
        escapeVelocityKmh: escapeVelocityKmh,
        dayLengthEarthDays: dayLengthEarthDays,
        yearLengthEarthDays: yearLengthEarthDays,
        orbitalSpeedKmh: orbitalSpeedKmh,
        atmosphereComposition: atmosphereComposition,
        moons: moons,
        image: image,
        description: description,
      );
}
