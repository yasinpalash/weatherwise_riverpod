import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherwise/models/weather_model.dart';
import '../core/constants/api_url.dart';
import '../models/area_model.dart';

class ApiService {
  static final _dio = Dio();

  Future<WeatherData?> fetchWeatherData(double lat, double lon) async {
    final url = weatherApiUrl(lat, lon);
    debugPrint("🌍 Fetching Weather Data from: $url");

    try {
      final response = await _dio.get(url);
      debugPrint("✅ Response status: ${response.statusCode}");
      debugPrint("📦 Response data: ${response.data}");

      if (response.statusCode == 200) {
        final weatherData =
            WeatherData.fromJson(response.data as Map<String, dynamic>);

        return weatherData;
      } else {
        debugPrint('❌ Failed to load weather data');
      }
    } on DioException catch (err) {
      debugPrint('⚠️ Error Occurred: $err');
    }
    return null;
  }

  Future<List<Area>?> fetchAreas(String area) async {
    final url = areaApiUrl(area);
    debugPrint("📍 Fetching Area Data from: $url");

    try {
      final response = await _dio.get(url);

      debugPrint("✅ Response status: ${response.statusCode}");
      debugPrint("📦 Response data: ${response.data}");

      if (response.statusCode == 200) {
        return (response.data as List)
            .map<Area>(
              (area) => Area.fromJson(area as Map<String, dynamic>),
            )
            .toList();
      }
    } on DioException catch (err) {
      debugPrint("⚠️ Error Occurred: ${err.message}");
    }
    return null;
  }
}
