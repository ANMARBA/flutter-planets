import 'dart:math' as math;

import 'package:flutter/material.dart';

class Star {
  final double dx;
  final double dy;
  final double radius;
  final double phase;
  const Star({
    required this.dx,
    required this.dy,
    required this.radius,
    required this.phase,
  });
}

class StarFieldPainter extends CustomPainter {
  final List<Star> stars;
  final double twinkle;

  const StarFieldPainter({
    required this.stars,
    required this.twinkle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < stars.length; i++) {
      final s = stars[i];

      final x = s.dx * size.width;
      final y = s.dy * size.height;

      final tw = (math.sin((twinkle * math.pi * 2 * 1.5) + s.phase) + 1) / 2;
      final alpha = 0.35 + (tw * 0.65);

      paint.color = Colors.white.withOpacity(alpha);
      canvas.drawCircle(Offset(x, y), s.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) {
    return oldDelegate.twinkle != twinkle || oldDelegate.stars != stars;
  }
}
