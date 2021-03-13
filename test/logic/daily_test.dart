import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/api/daily/daily.dart';

void main() {
  const api_address =
      "https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&units=metric&appid=29d40fe4d3395e6ac3b6876ca32b7fca";

  test('test daily sections', () async {
    http.Response response = await http.get(api_address);
    Map<String, dynamic> json = jsonDecode(response.body);
    Daily daily = Daily.fromJson(json["daily"]);
    print(daily.days.length);
    expect(daily.days.length, 8);
  });
}
