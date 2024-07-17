import 'package:shared_preferences/shared_preferences.dart';

class FavoritesHelper {
  static const String favoritesKey = 'favorites';

  static Future<Set<int>> getFavoriteIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favList = prefs.getStringList(favoritesKey) ?? [];
    return favList.map((id) => int.parse(id)).toSet();
  }

  static Future<void> toggleFavorite(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<int> favorites = await getFavoriteIds();
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    await prefs.setStringList(favoritesKey, favorites.map((id) => id.toString()).toList());
  }

  static Future<bool> isFavorite(int id) async {
    Set<int> favorites = await getFavoriteIds();
    return favorites.contains(id);
  }
}
