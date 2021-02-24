import 'package:weather/models/api/current_weather.dart';
import 'package:weather/models/api/hourly/data.dart';

class Hourly extends CurrentWeather {
  List<HourlyData> data;

  Hourly({List<dynamic> list}) {
    data = List<HourlyData>();
    list.forEach((element) {
      data.add(HourlyData.fromJson(element));
    });
  }

  factory Hourly.fromJson(List<dynamic> json) => _$HourlyFromJson(json);
}

Hourly _$HourlyFromJson(List<dynamic> list) {
  return Hourly(list: list);
}
