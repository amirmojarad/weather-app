
import 'dart:convert';

import 'package:test/test.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;

void main(){
  test("weather of tehran", () async{
    var response = await API.makeOneCall(36.4062, 55.0163);
    print(response.statusCode);
    var weather = Weather.fromJson(jsonDecode(response.body));
    print(weather.lat);
    print(weather.lon);
  });
  
  
  
}