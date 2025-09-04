import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_planets/core/presentation/widgets/error_state.dart';
import 'package:flutter_planets/features/planets/presentation/providers/planets_providers.dart';
import 'package:flutter_planets/features/planets/presentation/widgets/planet_card.dart';

class PlanetsPage extends ConsumerStatefulWidget {
  static const String routePath = '/planets';
  static const String routeName = 'PlanetsPage';

  const PlanetsPage({super.key});

  @override
  ConsumerState<PlanetsPage> createState() => _PlanetsPageState();
}

class _PlanetsPageState extends ConsumerState<PlanetsPage> {
  final _searchCtrl = TextEditingController();
  final _refreshController = RefreshController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _onQueryChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      ref.read(planetsListControllerProvider.notifier).filterByName(q);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planetas')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B1023), Color(0xFF1B2440)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                key: const Key('planetsSearchByName'),
                controller: _searchCtrl,
                onChanged: _onQueryChanged,
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre (ej. Mercury, Venus...)',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0x18FFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                header: const WaterDropHeader(),
                onRefresh: () async {
                  try {
                    await ref
                        .read(planetsListControllerProvider.notifier)
                        .refreshList();

                    final q = _searchCtrl.text.trim();
                    if (q.isNotEmpty) {
                      ref
                          .read(planetsListControllerProvider.notifier)
                          .filterByName(q);
                    }

                    _refreshController.refreshCompleted();
                  } catch (_) {
                    _refreshController.refreshFailed();
                  }
                },
                child: Builder(builder: (context) {
                  final planetsAsync = ref.watch(planetsListControllerProvider);

                  return planetsAsync.when(
                    data: (planets) => ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: planets.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => PlanetCard(planet: planets[i]),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, st) =>
                        ErrorState(title: 'Error al cargar planetas', error: e),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
