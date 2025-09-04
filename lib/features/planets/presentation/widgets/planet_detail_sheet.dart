import 'package:flutter/material.dart';

import 'package:flutter_planets/features/planets/domain/entities/planet_entity.dart';

class PlanetDetailSheet extends StatelessWidget {
  final PlanetEntity planet;

  const PlanetDetailSheet({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF1B2440),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(planet.image),
                  radius: 48,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                planet.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                planet.description,
                style: const TextStyle(color: Colors.white70),
              ),
              const Divider(height: 24, color: Colors.white24),
              _buildStatRow(
                  'Distancia orbital', '${planet.orbitalDistanceKm} km'),
              _buildStatRow(
                  'Radio ecuatorial', '${planet.equatorialRadiusKm} km'),
              _buildStatRow('Volumen', '${planet.volumeKm3} km³'),
              _buildStatRow('Masa', planet.massKg),
              _buildStatRow('Densidad', '${planet.densityGCm3} g/cm³'),
              _buildStatRow('Gravedad', '${planet.surfaceGravityMS2} m/s²'),
              _buildStatRow(
                  'Vel. de escape', '${planet.escapeVelocityKmh} km/h'),
              _buildStatRow(
                  'Duración del día', '${planet.dayLengthEarthDays} días'),
              _buildStatRow(
                  'Duración del año', '${planet.yearLengthEarthDays} días'),
              _buildStatRow('Vel. orbital', '${planet.orbitalSpeedKmh} km/h'),
              _buildStatRow('Atmósfera', planet.atmosphereComposition),
              _buildStatRow('Lunas', '${planet.moons}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
