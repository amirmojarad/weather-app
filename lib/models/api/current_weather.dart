import 'package:weather/models/api/conditions/weather.dart';

class CurrentWeather {
  //Current time, Unix, UTC
  dynamic dt;

  //Sunrise and Sunrise time, Unix, UTC
  dynamic sunrise, sunset;

  // Temperature. Units - default: kelvin, metric: Celsius, imperial
  dynamic temp;
  dynamic feelsLike;
  dynamic pressure;
  dynamic humidity;

  // Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units – default: kelvin, metric: Celsius, imperial: Fahrenheit.
  dynamic dewPoint;

  // Cloudiness, %
  dynamic clouds;

  // Current UV index
  dynamic uvi;

  //Average visibility, metres
  dynamic visibility;

  //Wind speed. Wind speed. Units – default: metre/sec, metric: metre/sec, imperial: miles/hour. How to change units used
  dynamic windSpeed;

  //Wind direction, degrees (meteorological)
  dynamic windDeg;

  Weather weather;

  DateTime time;

  convertToTime() {
    this.time = DateTime.fromMillisecondsSinceEpoch(this.dt * 1000);
  }

  CurrentWeather({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.clouds,
    this.uvi,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
}

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) {
  return CurrentWeather(
    dt: json["dt"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    temp: json["temp"],
    feelsLike: json["feels_like"],
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"],
    uvi: json["uvi"],
    clouds: json["clouds"],
    visibility: json["visibility"],
    windSpeed: json["wind_speed"],
    windDeg: json["wind_deg"],
    weather: Weather.fromJson(
      (json["weather"] as List)[0],
    ),
  );
}
