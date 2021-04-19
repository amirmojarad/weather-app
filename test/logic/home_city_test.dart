import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/home_city/home_city.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;

void main() {
  HomeCity homeCity = HomeCity();
  test('null', () {
    expect(homeCity.weather, equals(null));
  });
  // in first test it works, and in the last test, i added london to home city and it change :)
  test('default', () async {
    var weather = await homeCity.loadHome();
    expect(weather.timezone.toString().toLowerCase(), equals('asia/tehran'));
  });
  Weather weather;
  test('change home', () async {
    var response = await API.makeOneCall(51.5074, 0.1278);
    Map<String, dynamic> json = await jsonDecode(response.body);
    weather = Weather.fromJson(json);
    homeCity.changeHome(weather);
    expect(homeCity.weather.timezone.toString().toLowerCase(),
        equals('europe/london'));
  });
  test('save/load home', () async {
    await homeCity.saveHome();
    weather = null;
    weather = await homeCity.loadHome();
    expect(weather.timezone.toString().toLowerCase(), equals('europe/london'));
  });
}
