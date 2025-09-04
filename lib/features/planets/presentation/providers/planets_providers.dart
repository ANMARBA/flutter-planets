import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_planets/core/domain/entities/failure.dart';
import 'package:flutter_planets/core/domain/usecases/usecase.dart';
import 'package:flutter_planets/features/planets/domain/entities/planet_entity.dart';
import 'package:flutter_planets/features/planets/domain/repositories/planets_repository.dart';
import 'package:flutter_planets/features/planets/domain/use_cases/get_planets_usecase.dart';

final planetsRepositoryProvider = Provider<PlanetsRepository>((ref) {
  throw UnimplementedError();
});

final getAvailableFieldsUseCaseProvider =
    Provider<GetAvailableFieldsUseCase>((ref) {
  final repo = ref.read(planetsRepositoryProvider);
  return GetAvailableFieldsUseCase(repository: repo);
});

final planetsListControllerProvider = AsyncNotifierProvider.autoDispose<
    PlanetsListController, List<PlanetEntity>>(
  () => PlanetsListController(),
);

class PlanetsListController
    extends AutoDisposeAsyncNotifier<List<PlanetEntity>> {
  late List<PlanetEntity> _all;

  @override
  Future<List<PlanetEntity>> build() async {
    final usecase = ref.read(getAvailableFieldsUseCaseProvider);
    final Either<Failure, List<PlanetEntity>> result =
        await usecase(NoParams());

    return result.fold(
      (failure) => Future.error(failure),
      (data) {
        _all = data;
        return data;
      },
    );
  }

  void filterByName(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      state = AsyncData(_all);
      return;
    }
    final filtered = _all
        .where((p) => p.name.toLowerCase().contains(q))
        .toList(growable: false);
    state = AsyncData(filtered);
  }

  Future<void> refreshList() async {
    ref.invalidateSelf();
    await future;
  }
}
