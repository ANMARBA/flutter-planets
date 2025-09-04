import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_planets/core/presentation/routes/app_router.dart';
import 'package:flutter_planets/core/shared/di/locator.dart';
import 'package:flutter_planets/features/planets/domain/repositories/planets_repository.dart';
import 'package:flutter_planets/features/planets/presentation/providers/planets_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(
    ProviderScope(
      overrides: [
        planetsRepositoryProvider.overrideWithValue(
          locator<PlanetsRepository>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final goRouter = locator<AppRouter>().goRouter;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es')],
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) => child!),
          ],
        );
      },
    );
  }
}
