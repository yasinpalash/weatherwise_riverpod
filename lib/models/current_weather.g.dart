// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentAdapter extends TypeAdapter<Current> {
  @override
  final int typeId = 4;

  @override
  Current read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Current(
      dt: fields[0] as int?,
      sunrise: fields[1] as int?,
      sunset: fields[2] as int?,
      temp: fields[3] as double?,
      feelsLike: fields[4] as double?,
      pressure: fields[5] as int?,
      humidity: fields[6] as int?,
      dewPoint: fields[7] as double?,
      uvi: fields[8] as double?,
      clouds: fields[9] as int?,
      visibility: fields[10] as int?,
      windSpeed: fields[11] as double?,
      windDeg: fields[12] as int?,
      windGust: fields[13] as double?,
      weather: (fields[14] as List?)?.cast<WeatherDescription>(),
    );
  }

  @override
  void write(BinaryWriter writer, Current obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.dt)
      ..writeByte(1)
      ..write(obj.sunrise)
      ..writeByte(2)
      ..write(obj.sunset)
      ..writeByte(3)
      ..write(obj.temp)
      ..writeByte(4)
      ..write(obj.feelsLike)
      ..writeByte(5)
      ..write(obj.pressure)
      ..writeByte(6)
      ..write(obj.humidity)
      ..writeByte(7)
      ..write(obj.dewPoint)
      ..writeByte(8)
      ..write(obj.uvi)
      ..writeByte(9)
      ..write(obj.clouds)
      ..writeByte(10)
      ..write(obj.visibility)
      ..writeByte(11)
      ..write(obj.windSpeed)
      ..writeByte(12)
      ..write(obj.windDeg)
      ..writeByte(13)
      ..write(obj.windGust)
      ..writeByte(14)
      ..write(obj.weather);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherDescriptionAdapter extends TypeAdapter<WeatherDescription> {
  @override
  final int typeId = 5;

  @override
  WeatherDescription read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherDescription(
      id: fields[0] as int?,
      main: fields[1] as String?,
      description: fields[2] as String?,
      icon: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherDescription obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.main)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDescriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
