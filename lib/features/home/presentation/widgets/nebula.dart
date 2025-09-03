import 'dart:math' as math;

import 'package:flutter/material.dart';

class Nebula extends StatelessWidget {
  final Offset center;
  final Color colorA;
  final Color colorB;

  final double radiusFactor;
  final double opacity;

  const Nebula({
    super.key,
    required this.center,
    required this.colorA,
    required this.colorB,
    required this.radiusFactor,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      final w = c.maxWidth;
      final h = c.maxHeight;
      final r = math.min(w, h) * radiusFactor;

      return Positioned(
        left: (w * center.dx) - r,
        top: (h * center.dy) - r,
        width: r * 2,
        height: r * 2,
        child: IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [colorA.withOpacity(opacity), colorB.withOpacity(0.0)],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),
      );
    });
  }
}
