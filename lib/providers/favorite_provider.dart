import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive/hive.dart';
import '../core/constants/hive_constants.dart';
import '../models/favorite_location.dart';
import '../models/weather_model.dart';
import '../utils/get_location_name.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteLocationNotifier, List<FavoriteLocation>>(
        (ref) => FavoriteLocationNotifier());

class FavoriteLocationNotifier extends StateNotifier<List<FavoriteLocation>> {
  FavoriteLocationNotifier() : super([]) {
    _loadFavoriteLocationsFromDB();
  }

  final favoriteLocationBox =
      Hive.box<FavoriteLocation>(HiveConstants.favoriteLocationsBoxName);

  // -------------------- Load --------------------
  void _loadFavoriteLocationsFromDB() {
    final items = favoriteLocationBox.values.toList();
    state = items;
    debugPrint("Loaded favorites: ${items.length}");
  }

  // -------------------- Add / Update --------------------
  void addFavorite(
      double lat, double lon, WeatherData weather, Placemark place) {
    final index = state.indexWhere((loc) => loc.lat == lat && loc.lon == lon);

    if (index != -1) {
      // Update existing favorite
      final updated = state[index].copyWith(
        temp: weather.current!.temp!.toInt(),
        icon: weather.current!.weather![0].icon,
        description: weather.current!.weather![0].description,
      );
      // Update state
      final newList = [...state];
      newList[index] = updated;
      state = newList;
      // Update Hive
      favoriteLocationBox.putAt(index, updated);
      return;
    }

    // Add new favorite
    final fav = FavoriteLocation(
      lat: lat,
      lon: lon,
      city: getLocationName(place),
      country: place.country ?? '',
      temp: weather.current!.temp!.toInt(),
      description: weather.current!.weather![0].description,
      icon: weather.current!.weather![0].icon,
    );

    state = [...state, fav];
    favoriteLocationBox.add(fav);
  }

  // -------------------- Remove --------------------
  void removeFavorite(FavoriteLocation fav) {
    final index = state.indexOf(fav);
    if (index == -1) return;

    final newList = [...state]..removeAt(index);
    state = newList;

    favoriteLocationBox.deleteAt(index);
  }

  // -------------------- Clear All --------------------
  void clearFavorites() {
    state = [];
    favoriteLocationBox.clear();
  }
}
