import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/home_city/home_city.dart';
import 'package:weather/views/cities_view/widgets/cities_card.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;

//TODO DELETING ITEM IN LIST!!!!!

class CitiesView extends StatefulWidget {
  ScrollController controller;
  CitiesHandler citiesHandler;
  HomeCity homeCity;

  CitiesView(this.controller, this.citiesHandler, this.homeCity);

  @override
  _CitiesViewState createState() => _CitiesViewState();
}

class _CitiesViewState extends State<CitiesView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: widget.controller,
        child: widget.citiesHandler.cities.cities.length != 0
            ? Padding(
                padding: const EdgeInsets.only(top: 33.0),
                child: Container(
                  height: device.height,
                  child: ListView.builder(
                    itemCount: widget.citiesHandler.cities.cities.length,
                    itemBuilder: (context, index) {
                      var city = widget.citiesHandler.cities.cities[index];
                      return CitiesCard(
                          city: city,
                          setAsDefault: () async {
                            var response =
                                await API.makeOneCall(city.lat, city.lon);
                            Weather weather = Weather.fromJson(
                                await jsonDecode(response.body));
                            widget.homeCity.changeHome(weather);
                            await widget.homeCity.saveHome();
                            return true;
                          },
                          delete: () async {
                            if (widget.citiesHandler.cities.cities
                                .contains(city)) {
                              widget.citiesHandler.cities.cities.remove(city);
                              await widget.citiesHandler.save();
                            }
                          },
                          setMainState: () async {
                            await widget.citiesHandler.load();
                            widget.citiesHandler.cities.cities
                                .forEach((element) {
                              print(element.city);
                            });
                            setState(() {});
                          });
                    },
                  ),
                ))
            : Center(
                child: Text(
                  "List Is Empty",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
      ),
    );
  }
}
