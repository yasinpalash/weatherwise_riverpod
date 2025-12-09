import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:weatherwise/models/favorite_location.dart';
import '../core/constants/hive_constants.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteLocationNotifier, List<FavoriteLocation>>(
        (ref) {
  return FavoriteLocationNotifier();
});

class FavoriteLocationNotifier extends StateNotifier<List<FavoriteLocation>> {
  FavoriteLocationNotifier() : super([]) {
    _loadFavoriteLocationsFromDB();
  }
  void removeFavorite(FavoriteLocation fav) {
    state = state.where((ele) => ele != fav).toList();
    _saveFavoriteLocationInDB(state);
  }
  //! Hive-related operations
  final favoriteLocationBox =
      Hive.box<List<FavoriteLocation>>(HiveConstants.favoriteLocationsBoxName);
  void _loadFavoriteLocationsFromDB() {
    final favorites = favoriteLocationBox.values.cast<List<FavoriteLocation>>();
    final favs = favorites.toList().expand((element) => element).toList();

    if (favs.isEmpty) {
      state = [];
    } else {
      state = favs;
    }
    debugPrint('Loaded $favs');
  }

  void _saveFavoriteLocationInDB(List<FavoriteLocation> favs) {
    favoriteLocationBox.put(HiveConstants.favoriteLocationsKey, favs);
    debugPrint('Saved $favs');
  }

}
