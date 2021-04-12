import 'package:flutter/cupertino.dart';
import 'package:weather/models/api/hourly/data.dart';
import 'package:weather/models/api/weather.dart';

class HomeViewController {
  Weather weather;
  ScrollController scrollController;

  HomeViewController({this.weather, this.scrollController});

  String getCityName() {
    String city = weather.timezone;
    city = city.substring(city.indexOf("/")).substring(1);
    return city;
  }

  DateTime getCurrentTime() {
    return this.weather.hourly.dt as DateTime;
  }

  String getTime(HourlyData data) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(data.dt);
    return time.toString();
  }

}
