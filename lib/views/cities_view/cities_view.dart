import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/api/minutely/data.dart';
import 'package:weather/models/api/minutely/minutely.dart';
import 'package:weather/models/utils/device.dart';

class CitiesView extends StatefulWidget {
  @override
  _CitiesViewState createState() => _CitiesViewState();
}

class _CitiesViewState extends State<CitiesView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Opacity(
              opacity: 0.8,
              child: Container(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () async {
                      http.Response response = await http.get(
                          "https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&appid=29d40fe4d3395e6ac3b6876ca32b7fca");
                      Map<String, dynamic> json =
                          await jsonDecode(response.body);
                    },
                    splashColor: Colors.black.withOpacity(0.5),
                    child: Column(children: [
                      Text(
                        "City's Name",
                      ),
                      Text("Country")
                    ]),
                  ),
                ),
                width: device.width / 2.2,
                height: device.height / 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff38FE62),
                    Color(0xffA3F8B5),
                  ]),
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
