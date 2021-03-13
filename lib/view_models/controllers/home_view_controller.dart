import 'package:flutter/cupertino.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/views/home/widgets/sections/hourly_card.dart';

class HomeViewController {
  Weather weather;
  ScrollController scrollController;

  HomeViewController({this.weather, this.scrollController});

  String getCityName() {
    String city = weather.timezone;
    city = city.substring(city.indexOf("/")).substring(1);
    return city;
  }

  List<Widget> generateCard() {
    List<Widget> cards = [];
    weather.hourly.data.forEach((element) {
      cards.add(buildHourlyCard(element));
    });
    return cards.sublist(0, 25);
  }
}
