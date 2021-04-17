import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weather/models/api/hourly/data.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;
import 'package:weather/views/city_view/city_view.dart';

class HomeViewController {
  Weather weather;
  ScrollController scrollController;

  HomeViewController({this.weather, this.scrollController});

  Future<Widget> getData(
      double lat, double lon, ScrollController controller) async {
    var response = await API.makeOneCall(lat, lon);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
      return CityView(weather, controller);
    } else
      throw Exception("Connection Failed");
  }
}
