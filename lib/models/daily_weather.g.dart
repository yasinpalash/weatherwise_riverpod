// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyAdapter extends TypeAdapter<Daily> {
  @override
  final int typeId = 2;

  @override
  Daily read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Daily(
      dt: fields[0] as int?,
      sunrise: fields[1] as int?,
      sunset: fields[2] as int?,
      moonrise: fields[3] as int?,
      moonset: fields[4] as int?,
      moonPhase: fields[5] as double?,
      summary: fields[6] as String?,
      temp: fields[7] as DailyTemp?,
      feelsLike: fields[8] as DailyFeelsLike?,
      pressure: fields[9] as int?,
      humidity: fields[10] as int?,
      dewPoint: fields[11] as double?,
      windSpeed: fields[12] as double?,
      windDeg: fields[13] as int?,
      windGust: fields[14] as double?,
      weather: (fields[15] as List?)?.cast<WeatherDescription>(),
      clouds: fields[16] as int?,
      pop: fields[17] as double?,
      uvi: fields[18] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Daily obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.dt)
      ..writeByte(1)
      ..write(obj.sunrise)
      ..writeByte(2)
      ..write(obj.sunset)
      ..writeByte(3)
      ..write(obj.moonrise)
      ..writeByte(4)
      ..write(obj.moonset)
      ..writeByte(5)
      ..write(obj.moonPhase)
      ..writeByte(6)
      ..write(obj.summary)
      ..writeByte(7)
      ..write(obj.temp)
      ..writeByte(8)
      ..write(obj.feelsLike)
      ..writeByte(9)
      ..write(obj.pressure)
      ..writeByte(10)
      ..write(obj.humidity)
      ..writeByte(11)
      ..write(obj.dewPoint)
      ..writeByte(12)
      ..write(obj.windSpeed)
      ..writeByte(13)
      ..write(obj.windDeg)
      ..writeByte(14)
      ..write(obj.windGust)
      ..writeByte(15)
      ..write(obj.weather)
      ..writeByte(16)
      ..write(obj.clouds)
      ..writeByte(17)
      ..write(obj.pop)
      ..writeByte(18)
      ..write(obj.uvi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DailyTempAdapter extends TypeAdapter<DailyTemp> {
  @override
  final int typeId = 3;

  @override
  DailyTemp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyTemp(
      morn: fields[0] as double?,
      day: fields[1] as double?,
      eve: fields[2] as double?,
      night: fields[3] as double?,
      min: fields[4] as double?,
      max: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, DailyTemp obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.morn)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.eve)
      ..writeByte(3)
      ..write(obj.night)
      ..writeByte(4)
      ..write(obj.min)
      ..writeByte(5)
      ..write(obj.max);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyTempAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DailyFeelsLikeAdapter extends TypeAdapter<DailyFeelsLike> {
  @override
  final int typeId = 6;

  @override
  DailyFeelsLike read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyFeelsLike(
      morn: fields[0] as double?,
      day: fields[1] as double?,
      eve: fields[2] as double?,
      night: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, DailyFeelsLike obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.morn)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.eve)
      ..writeByte(3)
      ..write(obj.night);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyFeelsLikeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
