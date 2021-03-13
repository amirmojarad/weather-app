import 'package:weather/models/api/daily/day_weather.dart';
import 'package:weather/models/api/daily/day_weathers.dart';
import 'package:weather/models/api/daily/feels_like.dart';
import 'package:weather/models/api/daily/temp.dart';

class Day {
  dynamic dt;
  dynamic sunrise;
  dynamic sunset;
  Temp temp;
  FeelsLike feelsLike;
  dynamic pressure;
  dynamic humidity;
  dynamic dewPoint;
  dynamic windSpeed;
  dynamic windDeg;
  dynamic clouds;
  dynamic pop;
  dynamic uvi;
  DayWeathers weather;

  Day(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.clouds,
      this.pop,
      this.uvi,
      this.weather});

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
}

Day _$DayFromJson(Map<String, dynamic> json) {
  return Day(
    weather: DayWeathers.fromJson(json["weather"] as List),
    dt: json["dt"],
    windDeg: json["wind_deg"],
    windSpeed: json["wind_speed"],
    sunset: json["sunset"],
    sunrise: json["sunrise"],
    temp: Temp.fromJson(json["temp"]),
    feelsLike: FeelsLike.fromJson(json["feels_like"]),
    clouds: json["clouds"],
    uvi: json["uvi"],
    dewPoint: json["dew_point"],
    humidity: json["humidity"],
    pop: json["pop"],
    pressure: json["pressure"],
  );
}
