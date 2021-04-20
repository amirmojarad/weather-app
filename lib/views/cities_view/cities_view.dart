import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/home_city/home_city.dart';
import 'package:weather/views/cities_view/widgets/cities_card.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;

class CitiesView extends StatefulWidget {
  ScrollController controller;
  CitiesHandler citiesHandler;
  HomeCity homeCity;

  CitiesView(this.controller, this.citiesHandler, this.homeCity);

  @override
  _CitiesViewState createState() => _CitiesViewState();
}

class _CitiesViewState extends State<CitiesView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: widget.controller,
        child: widget.citiesHandler.cities.cities.length != 0
            ? Column(
                children: List.generate(
                    widget.citiesHandler.cities.cities.length, (index) {
                  var city = widget.citiesHandler.cities.cities[index];
                  return CitiesCard(widget.citiesHandler.cities.cities[index],
                      () async {
                    var response = await API.makeOneCall(city.lat, city.lon);
                    Weather weather =
                        Weather.fromJson(await jsonDecode(response.body));
                    widget.homeCity.changeHome(weather);
                    await widget.homeCity.saveHome();
                  },
                      widget.homeCity.weather.lat == city.lat &&
                          widget.homeCity.weather.lon == city.lon);
                }),
              )
            : Center(
                child: Text("List Is Empty"),
              ),
      ),
    );
  }
}
