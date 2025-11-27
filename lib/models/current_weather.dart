import 'package:hive/hive.dart';
part 'current_weather.g.dart';
@HiveType(typeId: 4)
class Current extends HiveObject {
  @HiveField(0)
  int? dt;

  @HiveField(1)
  int? sunrise;

  @HiveField(2)
  int? sunset;

  @HiveField(3)
  double? temp;

  @HiveField(4)
      double? feelsLike;

      @HiveField(5)
  int? pressure;

  @HiveField(6)
  int? humidity;

  @HiveField(7)
  double? dewPoint;

  @HiveField(8)
  double? uvi;

  @HiveField(9)
  int? clouds;

  @HiveField(10)
  int? visibility;

  @HiveField(11)
  double? windSpeed;

  @HiveField(12)
  int? windDeg;

  @HiveField(13)
  double? windGust;

  @HiveField(14)
  List<WeatherDescription>? weather;

  Current({
    this.dt,
    this.sunrise,
    this.sunset,
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
  });

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
       sunrise = json['sunrise'];
    sunset = json['sunset'];
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
    weather = (json['weather'] as List?)
        ?.map((e) => WeatherDescription.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
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
      'weather': weather?.map((e) => e.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 5)
class WeatherDescription extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? main;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? icon;

  WeatherDescription({this.id, this.main, this.description, this.icon});

  WeatherDescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}
