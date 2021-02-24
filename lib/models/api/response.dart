import 'package:weather/models/api/current_weather.dart';
import 'package:weather/models/api/hourly/hourly.dart';
import 'package:weather/models/api/minutely/minutely.dart';

class APIResponse {
  double lon, lat;
  String timezone, timezoneOffset;
  CurrentWeather current;
  Minutely minutely;
  Hourly hourly;
}
