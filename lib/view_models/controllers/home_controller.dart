import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;
import 'package:weather/views/home/home_view.dart';

class HomeController {
  Weather weather;

  Future<Widget> getData(double lat, double lon) async {
    var response = await API.makeOneCall(lat, lon);
    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
      return HomeView(weather);
    } else
      throw Exception("Connection Failed");
  }
}
