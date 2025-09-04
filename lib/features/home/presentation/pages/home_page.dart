import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter_planets/core/presentation/routes/routes.dart'
    show PlanetsPage;
import 'package:flutter_planets/features/home/presentation/widgets/nebula.dart';
import 'package:flutter_planets/features/home/presentation/widgets/planet_dot.dart';
import 'package:flutter_planets/features/home/presentation/widgets/rotating_ring.dart';
import 'package:flutter_planets/features/home/presentation/widgets/star_field_painter.dart';

class HomePage extends StatefulWidget {
  static const String routePath = '/home';
  static const String routeName = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<Star> _stars;

  static const _heroSunTag = 'hero-sun';
  static const _starCount = 140;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();

    final rand = math.Random(42);
    _stars = List.generate(_starCount, (i) {
      final radius = (rand.nextDouble() * 1.5) + 0.4;
      final phase = rand.nextDouble() * math.pi * 2;

      return Star(
        dx: rand.nextDouble(),
        dy: rand.nextDouble(),
        radius: radius,
        phase: phase,
      );
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF070C1A), Color(0xFF121B3A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: StarFieldPainter(
                    stars: _stars,
                    twinkle: _ctrl.value,
                  ),
                ),
                const Nebula(
                  center: Offset(0.2, 0.25),
                  colorA: Color(0xFF7C4DFF),
                  colorB: Color(0xFFE040FB),
                  radiusFactor: 0.42,
                  opacity: 0.10,
                ),
                const Nebula(
                  center: Offset(0.85, 0.65),
                  colorA: Color(0xFF00E5FF),
                  colorB: Color(0xFF18FFFF),
                  radiusFactor: 0.35,
                  opacity: 0.10,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Explora el Sistema Solar',
                          textAlign: TextAlign.center,
                          style: t.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Una aventura visual por nuestros planetas',
                          textAlign: TextAlign.center,
                          style: t.bodyMedium?.copyWith(
                            color: Colors.white70,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Center(
                          child: SizedBox(
                            height: 280,
                            width: 280,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Hero(
                                  tag: _heroSunTag,
                                  child: Container(
                                    height: 96,
                                    width: 96,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          Color(0xFFFFE082),
                                          Color(0xFFFFA726),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x66FFB74D),
                                          blurRadius: 28,
                                          spreadRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.wb_sunny,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                RotatingRing(
                                  angle: _ctrl.value * 2 * math.pi,
                                  diameter: 160,
                                  ringOpacity: 0.12,
                                  children: const [
                                    PlanetDot(
                                      size: 16,
                                      color: Color(0xFF90CAF9),
                                    ),
                                  ],
                                ),
                                RotatingRing(
                                  angle: -_ctrl.value * 2 * math.pi * 0.8,
                                  diameter: 200,
                                  ringOpacity: 0.12,
                                  children: const [
                                    PlanetDot(
                                      size: 14,
                                      color: Color(0xFFF48FB1),
                                    ),
                                    PlanetDot(
                                      size: 10,
                                      color: Color(0xFFFFF59D),
                                      offsetAngle: 2,
                                    ),
                                  ],
                                ),
                                RotatingRing(
                                  angle: _ctrl.value * 2 * math.pi * 0.6,
                                  diameter: 240,
                                  ringOpacity: 0.10,
                                  children: const [
                                    PlanetDot(
                                      size: 18,
                                      color: Color(0xFFA5D6A7),
                                    ),
                                    PlanetDot(
                                      size: 12,
                                      color: Color(0xFF80CBC4),
                                      offsetAngle: 1.4,
                                    ),
                                    PlanetDot(
                                      size: 10,
                                      color: Color(0xFFCE93D8),
                                      offsetAngle: 3.3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Semantics(
                          button: true,
                          label: 'Ver Planetas',
                          child: ElevatedButton.icon(
                            key: const Key('seePlanetsButton'),
                            onPressed: () =>
                                context.pushNamed(PlanetsPage.routeName),
                            icon: const Icon(Icons.rocket_launch),
                            label: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text('Ver Planetas'),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: t.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
