import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_planets/core/shared/di/locator.dart';
import 'package:flutter_planets/features/planets/domain/repositories/favorites_repitory.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  static const _key = 'favorite_planets';

  final _pref = locator<SharedPreferences>();

  @override
  Future<List<String>> loadFavorites() async {
    return _pref.getStringList(_key) ?? [];
  }

  @override
  Future<void> toggleFavorite(String planetName) async {
    final favorites = _pref.getStringList(_key) ?? [];
    if (favorites.contains(planetName)) {
      favorites.remove(planetName);
    } else {
      favorites.add(planetName);
    }
    await _pref.setStringList(_key, favorites);
  }

  @override
  Future<bool> isFavorite(String planetName) async {
    final favorites = _pref.getStringList(_key) ?? [];
    return favorites.contains(planetName);
  }
}
