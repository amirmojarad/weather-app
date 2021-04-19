import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/cities_handler/file_handler.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;

class HomeCity {
  Weather weather;
  FileHandler fileHandler = FileHandler('homeCity');

  Future<Weather> loadHome() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('lat') && _prefs.containsKey('lon')) {
      var lat = _prefs.getDouble('lat');
      var lon = _prefs.getDouble('lon');
      var response = await API.makeOneCall(lat, lon);
      Map<String, dynamic> json = await jsonDecode(response.body);
      this.weather = Weather.fromJson(json);
      return this.weather;
    } else {
      // default city is TEHRAN!
      var response = await API.makeOneCall(35.6892, 51.3890);
      Map<String, dynamic> json = await jsonDecode(response.body);
      this.weather = Weather.fromJson(json);
      await saveHome();
      return this.weather;
    }
  }

  Future<void> saveHome() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble('lat', this.weather.lat);
    _prefs.setDouble('lon', this.weather.lon);
  }

  void changeHome(Weather weather) {
    this.weather = weather;
  }
}
