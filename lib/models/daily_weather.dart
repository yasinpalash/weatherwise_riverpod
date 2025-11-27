import 'package:hive/hive.dart';
import 'current_weather.dart';
part 'daily_weather.g.dart';


@HiveType(typeId: 2)
class Daily extends HiveObject {
  @HiveField(0)
  int? dt;

  @HiveField(1)
  int? sunrise;

  @HiveField(2)
  int? sunset;

  @HiveField(3)
  int? moonrise;

  @HiveField(4)
  int? moonset;

  @HiveField(5)
  double? moonPhase;

  @HiveField(6)
  String? summary;

  @HiveField(7)
  DailyTemp? temp;

  @HiveField(8)
  DailyFeelsLike? feelsLike;

  @HiveField(9)
  int? pressure;

  @HiveField(10)
  int? humidity;

  @HiveField(11)
  double? dewPoint;

  @HiveField(12)
  double? windSpeed;

  @HiveField(13)
  int? windDeg;

  @HiveField(14)
  double? windGust;

  @HiveField(15)
  List<WeatherDescription>? weather;

  @HiveField(16)
  int? clouds;

  @HiveField(17)
  double? pop;

  @HiveField(18)
  double? uvi;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.summary,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.uvi,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = (json['moon_phase'] as num?)?.toDouble();
    summary = json['summary'];
    temp = json['temp'] != null ? DailyTemp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null ? DailyFeelsLike.fromJson(json['feels_like']) : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = (json['dew_point'] as num?)?.toDouble();
    windSpeed = (json['wind_speed'] as num?)?.toDouble();
    windDeg = json['wind_deg'];
    windGust = (json['wind_gust'] as num?)?.toDouble();
    clouds = json['clouds'];
    pop = (json['pop'] as num?)?.toDouble();
    uvi = (json['uvi'] as num?)?.toDouble();
    weather = (json['weather'] as List?)
        ?.map((e) => WeatherDescription.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
      'moonrise': moonrise,
      'moonset': moonset,
      'moon_phase': moonPhase,
      'summary': summary,
      'temp': temp?.toJson(),
      'feels_like': feelsLike?.toJson(),
      'pressure': pressure,
      'humidity': humidity,
      'dew_point': dewPoint,
      'wind_speed': windSpeed,
      'wind_deg': windDeg,
      'wind_gust': windGust,
      'weather': weather?.map((e) => e.toJson()).toList(),
      'clouds': clouds,
      'pop': pop,
      'uvi': uvi,
    };
  }
}

@HiveType(typeId: 3)
class DailyTemp extends HiveObject {
  @HiveField(0)
  double? morn;

  @HiveField(1)
  double? day;

  @HiveField(2)
  double? eve;

  @HiveField(3)
  double? night;

  @HiveField(4)
  double? min;

  @HiveField(5)
  double? max;

  DailyTemp({this.morn, this.day, this.eve, this.night, this.min, this.max});

  DailyTemp.fromJson(Map<String, dynamic> json) {
    morn = (json['morn'] as num?)?.toDouble();
    day = (json['day'] as num?)?.toDouble();
    eve = (json['eve'] as num?)?.toDouble();
    night = (json['night'] as num?)?.toDouble();
    min = (json['min'] as num?)?.toDouble();
    max = (json['max'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() => {
    'morn': morn,
    'day': day,
    'eve': eve,
    'night': night,
    'min': min,
    'max': max,
  };
}

@HiveType(typeId: 6)
class DailyFeelsLike extends HiveObject {
  @HiveField(0)
  double? morn;

  @HiveField(1)
  double? day;

  @HiveField(2)
  double? eve;

  @HiveField(3)
  double? night;

  DailyFeelsLike({this.morn, this.day, this.eve, this.night});

  DailyFeelsLike.fromJson(Map<String, dynamic> json) {
    morn = (json['morn'] as num?)?.toDouble();
    day = (json['day'] as num?)?.toDouble();
    eve = (json['eve'] as num?)?.toDouble();
    night = (json['night'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() => {
    'morn': morn,
    'day': day,
    'eve': eve,
    'night': night,
  };
}