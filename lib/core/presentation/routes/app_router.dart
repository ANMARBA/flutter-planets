import 'package:go_router/go_router.dart';

import 'package:flutter_planets/core/presentation/routes/routes.dart';

class AppRouter {
  final goRouter = GoRouter(
    initialLocation: HomePage.routePath,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: HomePage.routePath,
        name: HomePage.routeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: PlanetsPage.routePath,
        name: PlanetsPage.routeName,
        builder: (context, state) => const PlanetsPage(),
      ),
    ],
  );
}
