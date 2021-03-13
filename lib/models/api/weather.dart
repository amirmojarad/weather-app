import 'package:weather/models/api/current_weather.dart';
import 'package:weather/models/api/hourly/hourly.dart';
import 'package:weather/models/api/minutely/minutely.dart';

import 'daily/daily.dart';

class Weather {
  dynamic lon, lat;
  dynamic timezone, timezoneOffset;
  CurrentWeather current;
  Minutely minutely;
  Hourly hourly;
  Daily daily;

  Weather(
      {this.lon,
      this.lat,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.minutely,
      this.hourly,
      this.daily});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$APIResponseFromJson(json);
}

Weather _$APIResponseFromJson(Map<String, dynamic> json) {
  return Weather(
    current: CurrentWeather.fromJson(json["current"]),
    hourly: Hourly.fromJson(json["hourly"]),
    minutely: Minutely.fromJson(json["minutely"]),
    timezone: json["timezone"],
    timezoneOffset: json["timezone_offset"],
    lat: json["lat"],
    lon: json["lon"],
    daily: Daily.fromJson(json["daily"]),
  );
}
