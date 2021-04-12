import 'package:flutter/material.dart';
import 'package:weather/models/city_card_data.dart';
import 'package:weather/models/utils/device.dart';

class CitiesViewController {
  List<CityCardData> cities;

  CitiesViewController() {
    cities = [
      CityCardData("Tehran", "Icon", 2),
      CityCardData("Tehran", "Icon", 2),
      CityCardData("Tehran", "Icon", 2),
      CityCardData("Tehran", "Icon", 2),
      CityCardData("Tehran", "Icon", 2),
      CityCardData("Tehran", "Icon", 2),
      CityCardData("Tehran", "Icon", 2),
      CityCardData("Tehran", "Icon", 2),
      CityCardData("Tehran", "Icon", 2),
    ];
  }
}
