import 'package:hive/hive.dart';
import '../models/hourly_weather.dart';
import 'current_weather.dart';
import 'daily_weather.dart';
part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherData extends HiveObject {
  @HiveField(0)
  double? lat;

  @HiveField(1)
  double? lon;

  @HiveField(2)
  String? timezone;

  @HiveField(3)
  int? timezoneOffset;

  @HiveField(4)
  Current? current;

  @HiveField(5)
  List<Hourly>? hourly;

  @HiveField(6)
  List<Daily>? daily;

  WeatherData({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.hourly,
    this.daily,
  });

  WeatherData.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] as num?)?.toDouble();
    lon = (json['lon'] as num?)?.toDouble();
    timezone = json['timezone'] as String?;
    timezoneOffset = json['timezone_offset'] as int?;
    current = json['current'] != null ? Current.fromJson(json['current']) : null;
    if (json['hourly'] != null) {
      hourly = (json['hourly'] as List).map((v) => Hourly.fromJson(v)).toList();
    }
    if (json['daily'] != null) {
      daily = (json['daily'] as List).map((v) => Daily.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'timezone_offset': timezoneOffset,
      'current': current?.toJson(),
      'hourly': hourly?.map((v) => v.toJson()).toList(),
      'daily': daily?.map((v) => v.toJson()).toList(),
    };
  }
}