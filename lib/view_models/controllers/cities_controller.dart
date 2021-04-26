import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;
import 'package:weather/view_models/database_handler/city.dart';
import 'package:weather/views/city_view/city_view.dart';

class CitiesController {
  ScrollController controller;
  City city;

  CitiesController(this.city);

  Future<Map<String, dynamic>> getData() async {
    Weather weather;
    var response = await API.makeOneCall(city.lat, city.lon);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
      return {'widget': CityView(weather, controller), 'weather': weather};
    } else
      throw Exception("Connection Failed");
  }
}
