abstract class FavoritesRepository {
  Future<List<String>> loadFavorites();
  Future<void> toggleFavorite(String planetName);
  Future<bool> isFavorite(String planetName);
}
