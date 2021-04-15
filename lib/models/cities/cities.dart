import 'package:flutter/material.dart';
import 'package:weather/view_models/database_handler/city.dart';

class Cities {
  List<City> cities;

  Cities() {
    this.cities = [];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    cities.forEach((element) {
      json.putIfAbsent(element.id, () => element.toJson());
    });
    return json;
  }

  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);
}

Cities _$CitiesFromJson(Map<String, dynamic> json) {
  Cities cities = Cities();
  json.forEach((key, value) {
    cities.cities.add(value);
  });
  return cities;
}
