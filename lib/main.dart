import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'core/constants/hive_constants.dart';
import 'models/current_weather.dart';
import 'models/daily_weather.dart';
import 'models/favorite_location.dart';
import 'models/hourly_weather.dart';
import 'models/weather_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! Initializing Hive
  final appStorageDirPath = await getApplicationDocumentsDirectory();
  Hive.initFlutter();
  Hive.init(appStorageDirPath.path);

  //! registering the adapters
  await registerHiveAdapters();

  //! Opening Hive boxes
  await Hive.openBox<WeatherData>(HiveConstants.weatherDataBoxName);
  await Hive.openBox<FavoriteLocation>(HiveConstants.favoriteLocationsBoxName);
  await Hive.openBox<String>(HiveConstants.prefBoxName);
  await Hive.openBox<bool>(HiveConstants.hasDataFetchedOnceBoxName);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}


Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(WeatherDataAdapter());
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(HourlyAdapter());
  if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(DailyAdapter());
  if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(DailyTempAdapter());
  if (!Hive.isAdapterRegistered(4)) Hive.registerAdapter(CurrentAdapter());
  if (!Hive.isAdapterRegistered(5)) Hive.registerAdapter(WeatherDescriptionAdapter());
  if (!Hive.isAdapterRegistered(6)) Hive.registerAdapter(DailyFeelsLikeAdapter());
  if (!Hive.isAdapterRegistered(7)) Hive.registerAdapter(FavoriteLocationAdapter());
}