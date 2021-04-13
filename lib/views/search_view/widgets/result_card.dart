import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/database_handler/city.dart';
import 'package:weather/view_models/api_handler/responses.dart' as API;
import 'package:weather/views/home/home_view.dart';
import 'package:weather/views/progressbars/search_progress.dart';

Future<Widget> getData(
    double lat, double lon, ScrollController controller) async {
  Weather weather;
  var response = await API.makeOneCall(lat, lon);

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
    return HomeView(weather, controller);
  } else
    throw Exception("Connection Failed");
}

Widget buildResultCard(
    City city, BuildContext context, ScrollController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            Color(0xff36FF91),
            Color(0xff63FFA9),
            Color(0xff9CFFC8),
          ],
        ),
      ),
      width: device.width,
      height: device.height / 8,
      child: Material(
        animationDuration: Duration(milliseconds: 50),
        borderRadius: BorderRadius.circular(18),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          splashColor: Color(0xffD4FFE8).withOpacity(0.5),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FutureBuilder(
                          future: getData(city.lat, city.lon, controller),
                          builder: (context, snapshot) => snapshot.hasData
                              ? Scaffold(
                                  body: snapshot.data,
                                  appBar: AppBar(
                                    leading: IconButton(
                                      icon: Icon(Icons.arrow_back_ios),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  color: Colors.white,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                        )
                    // getData(city.lat, city.lon, controller),
                    ));
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: device.height / 50, left: device.width / 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.city,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  Text(
                    city.country,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
