import 'package:weather/models/api/conditions/weather.dart';

class DayWeathers {
  List<Weather> dayWeather;

  DayWeathers({this.dayWeather});

  factory DayWeathers.fromJson(List<dynamic> list) =>
      _$DayWeathersFromJson(list);
}

DayWeathers _$DayWeathersFromJson(List<dynamic> input) {
  List<Weather> list = [];
  input.forEach((element) {
    list.add(Weather.fromJson(element));
  });
  return DayWeathers(dayWeather: list);
}
