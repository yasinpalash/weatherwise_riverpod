import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:weatherwise/core/constants/hive_constants.dart';
import 'package:weatherwise/models/weather_model.dart';
import 'package:weatherwise/providers/internet_provider.dart';
import 'package:weatherwise/providers/search_provider.dart';

final weatherProvider = FutureProvider<WeatherData?>((ref) async {
  final searchState = ref.read(searchProvider);
  final internetState = ref.read(internetStatusProvider);

  //! Hive Boxes
  final weatherDataBox =
      Hive.box<WeatherData>(HiveConstants.weatherDataBoxName);
  final hasDataFetchedOnceBox =
      Hive.box<bool>(HiveConstants.hasDataFetchedOnceBoxName);

  WeatherData? weatherData;
});
