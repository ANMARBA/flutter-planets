import 'package:flutter/material.dart';

class PlanetDot extends StatelessWidget {
  final double size;
  final Color color;
  final double offsetAngle;

  const PlanetDot({
    super.key,
    required this.size,
    required this.color,
    this.offsetAngle = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Transform.translate(
        offset: Offset(0, -(size / 2) - 8),
        child: Transform.rotate(
          angle: offsetAngle,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
