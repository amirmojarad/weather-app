import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/models/cities/cities.dart';
import 'package:weather/view_models/cities_handler/file_handler.dart';
import 'package:weather/view_models/database_handler/city.dart';

void main() {
  test('Opening file, READ AND WRITE', () async {
    FileHandler fileHandler = FileHandler('cities');
    try {
      Cities cities = Cities();
      cities.cities.add(
          City(lon: 12.0, city: "te", id: "1", lat: 12.22, country: "ASd"));
      await fileHandler.write(cities.toJson());
      cities = Cities.fromJson(await fileHandler.read());
      expect(cities.cities.length, equals(1));
      expect(cities.cities[0].id, equals("1"));
    } catch (e) {
      print(e);
    }
  });
}
