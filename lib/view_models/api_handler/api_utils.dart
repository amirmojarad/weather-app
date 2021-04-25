import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

const String API_KEY = "29d40fe4d3395e6ac3b6876ca32b7fca";

String getIcons(String iconURL) {
  return "http://openweathermap.org/img/wn/$iconURL@2x.png";
}

IconData getIcon(String iconURL) {
  switch (iconURL) {
    case "01d":
      return WeatherIcons.wiDaySunny;
    case "01n":
      return WeatherIcons.wiNightClear;
    case "02n":
      return WeatherIcons.wiNightCloudy;
    case "02d":
      return WeatherIcons.wiDayCloudy;
    case "03n":
      return WeatherIcons.wiNightCloudy;
    case "03d":
      return WeatherIcons.wiCloud;
    case "04n":
      return WeatherIcons.wiCloud;
    case "04d":
      return WeatherIcons.wiCloud;
    case "09d":
      return WeatherIcons.wiRain;
    case "09n":
      return WeatherIcons.wiRain;
    case "10d":
      return WeatherIcons.wiDayRain;
    case "10n":
      return WeatherIcons.wiNightRain;

    case "11d":
      return WeatherIcons.wiDayThunderstorm;
    case "11n":
      return WeatherIcons.wiNightThunderstorm;
    case "13d":
      return WeatherIcons.wiSnow;
    case "13n":
      return WeatherIcons.wiSnow;
    case "50d":
      return WeatherIcons.wiFog;
    case "50n":
      return WeatherIcons.wiFog;
    default:
      return WeatherIcons.wiWindDirection;
  }
}

String generateOneCallRequest(double lon, double lat) {
  return "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$API_KEY";
}
