import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/models/api/hourly/data.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;
import 'package:weather/views/city_view/city_view.dart';

class HomeViewController {
  Weather weather;
  ScrollController scrollController;

  HomeViewController({this.weather, this.scrollController});

  Future<Widget> getData(
      double lat, double lon, ScrollController controller) async {
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      var response = await API.makeOneCall(lat, lon);
      if (response.statusCode == 200) {
        weather = Weather.fromJson(jsonDecode(response.body));
        return CityView(weather, controller);
      } else
        throw Exception("Connection Failed");
    }
    return Center(
      child: Container(
        child: Center(
          child: Image.asset('assets/images/No Internet Connection UI.jpg'),
        ),
        color: Color(0xffE2E6E7),
        width: device.width,
        height: device.height,
      ),
    );
  }
}
