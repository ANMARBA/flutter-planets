import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_planets/features/planets/domain/entities/planet_entity.dart';
import 'package:flutter_planets/features/planets/presentation/providers/favorites_providers.dart';

class PlanetDetailSheet extends ConsumerWidget {
  final PlanetEntity planet;

  const PlanetDetailSheet({super.key, required this.planet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesControllerProvider);
    final isFav = favorites.contains(planet.name);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    planet.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      ref
                          .read(favoritesControllerProvider.notifier)
                          .toggle(planet.name);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                planet.description,
                style: const TextStyle(color: Colors.white70),
              ),
              const Divider(height: 24, color: Colors.white24),
              _stat('Distancia orbital', '${planet.orbitalDistanceKm} km'),
              _stat('Radio ecuatorial', '${planet.equatorialRadiusKm} km'),
              _stat('Volumen', '${planet.volumeKm3} km³'),
              _stat('Masa', planet.massKg),
              _stat('Densidad', '${planet.densityGCm3} g/cm³'),
              _stat('Gravedad', '${planet.surfaceGravityMS2} m/s²'),
              _stat('Vel. de escape', '${planet.escapeVelocityKmh} km/h'),
              _stat('Duración del día', '${planet.dayLengthEarthDays} días'),
              _stat('Duración del año', '${planet.yearLengthEarthDays} días'),
              _stat('Vel. orbital', '${planet.orbitalSpeedKmh} km/h'),
              _stat('Atmósfera', planet.atmosphereComposition),
              _stat('Lunas', '${planet.moons}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
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
