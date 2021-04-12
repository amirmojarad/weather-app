import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

const String API_KEY = "29d40fe4d3395e6ac3b6876ca32b7fca";

String getIcons(String iconURL) {
  return "http://openweathermap.org/img/wn/$iconURL@2x.png";
}

Icon getIcon(String iconURL, double size) {
  IconData iconData;
  switch (iconURL) {
    case "01d":
      return Icon(WeatherIcons.wiDaySunny, size: size);
    case "01n":
      return Icon(WeatherIcons.wiNightClear, size: size);
    case "02n":
      return Icon(WeatherIcons.wiNightCloudy, size: size);
    case "02d":
      return Icon(WeatherIcons.wiDayCloudy, size: size);
    case "03n":
      return Icon(WeatherIcons.wiNightCloudy, size: size);
    case "03d":
      return Icon(WeatherIcons.wiCloud, size: size);
    case "04n":
      return Icon(WeatherIcons.wiCloud, size: size);
    case "04d":
      return Icon(WeatherIcons.wiCloud, size: size);
    case "09d":
      return Icon(WeatherIcons.wiRain, size: size);
    case "09n":
      return Icon(WeatherIcons.wiRain, size: size);
    case "10d":
      return Icon(WeatherIcons.wiDayRain, size: size);
    case "10n":
      return Icon(WeatherIcons.wiNightRain, size: size);

    case "11d":
      return Icon(WeatherIcons.wiDayThunderstorm, size: size);
    case "11n":
      return Icon(WeatherIcons.wiNightThunderstorm, size: size);
    case "13d":
      return Icon(WeatherIcons.wiSnow, size: size);
    case "13n":
      return Icon(WeatherIcons.wiSnow, size: size);
    case "50d":
      return Icon(WeatherIcons.wiFog, size: size);
    case "50n":
      return Icon(WeatherIcons.wiFog, size: size);
    default:
      return Icon(WeatherIcons.wiWindDirection);
  }
}

String generateOneCallRequest(double lon, double lat) {
  print(
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$API_KEY");
  return "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$API_KEY";
}
