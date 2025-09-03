import 'package:flutter/material.dart';

import 'package:flutter_planets/features/home/presentation/widgets/planet_dot.dart';

class RotatingRing extends StatelessWidget {
  final double angle;
  final double diameter;
  final double ringOpacity;
  final List<PlanetDot> children;

  const RotatingRing({
    super.key,
    required this.angle,
    required this.diameter,
    required this.ringOpacity,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: SizedBox(
        height: diameter,
        width: diameter,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: diameter,
              width: diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(ringOpacity),
                  width: 1,
                ),
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
