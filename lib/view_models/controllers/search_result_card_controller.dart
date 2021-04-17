import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/database_handler/city.dart';
import 'package:weather/views/city_view/city_view.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;

class SearchResultCardController {
  City city;
  ScrollController controller;

  bool tapped = false;

  SearchResultCardController({this.city, this.controller});

  void addToFavorites(CitiesHandler citiesHandler) {
    tapped = !tapped;
    if (tapped)
      citiesHandler.cities.cities.add(city);
    else
      citiesHandler.cities.cities.remove(city);
  }

  Future<Widget> getData() async {
    Weather weather;
    var response = await API.makeOneCall(city.lat, city.lon);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
      return CityView(weather, controller);
    } else
      throw Exception("Connection Failed");
  }
}
