import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_planets/features/planets/data/repositories/favorites_repository_impl.dart';
import 'package:flutter_planets/features/planets/domain/repositories/favorites_repitory.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl();
});

final favoritesControllerProvider =
    StateNotifierProvider<FavoritesController, List<String>>(
  (ref) {
    final repo = ref.watch(favoritesRepositoryProvider);
    return FavoritesController(repo);
  },
);

class FavoritesController extends StateNotifier<List<String>> {
  final FavoritesRepository _repository;

  FavoritesController(this._repository) : super([]) {
    _load();
  }

  Future<void> _load() async {
    state = await _repository.loadFavorites();
  }

  Future<void> toggle(String planetName) async {
    await _repository.toggleFavorite(planetName);
    state = await _repository.loadFavorites();
  }

  bool isFavorite(String planetName) => state.contains(planetName);
}
