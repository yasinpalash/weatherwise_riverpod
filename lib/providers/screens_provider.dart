import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/favorite_screen.dart';
import '../screens/preference_screen.dart';
import '../screens/search_screen.dart';
import '../screens/weather_screen.dart';

final screenIndexProvider = StateProvider((ref) => 0);

final screenProvider = Provider((ref) => [
      const WeatherScreen(),
      const SearchScreen(),
      const FavoriteScreen(),
      const PreferenceScreen(),
    ]);
