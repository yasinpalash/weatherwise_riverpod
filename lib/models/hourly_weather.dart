import 'package:hive/hive.dart';
import '../models/current_weather.dart';
part 'hourly_weather.g.dart';

@HiveType(typeId: 1)
class Hourly extends HiveObject {
  @HiveField(0)
  int? dt;

  @HiveField(1)
  double? temp;

  @HiveField(2)
  double? feelsLike;

  @HiveField(3)
  int? pressure;

  @HiveField(4)
  int? humidity;

  @HiveField(5)
  double? dewPoint;

  @HiveField(6)
  double? uvi;

  @HiveField(7)
  int? clouds;

  @HiveField(8)
  int? visibility;

  @HiveField(9)
  double? windSpeed;

  @HiveField(10)
  int? windDeg;

  @HiveField(11)
  double? windGust;

  @HiveField(12)
  List<WeatherDescription>? weather;

  @HiveField(13)
  double? pop;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = (json['temp'] as num?)?.toDouble();
    feelsLike = (json['feels_like'] as num?)?.toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = (json['dew_point'] as num?)?.toDouble();
    uvi = (json['uvi'] as num?)?.toDouble();
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = (json['wind_speed'] as num?)?.toDouble();
    windDeg = json['wind_deg'];
    windGust = (json['wind_gust'] as num?)?.toDouble();
    pop = (json['pop'] as num?)?.toDouble();
    weather = (json['weather'] as List?)
        ?.map((e) => WeatherDescription.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'temp': temp,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'dew_point': dewPoint,
      'uvi': uvi,
      'clouds': clouds,
      'visibility': visibility,
      'wind_speed': windSpeed,
      'wind_deg': windDeg,
      'wind_gust': windGust,
      'pop': pop,
      'weather': weather?.map((e) => e.toJson()).toList(),
    };
  }
}
