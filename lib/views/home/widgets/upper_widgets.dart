import 'package:flutter/material.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';
import 'package:weather/models/utils/converters/date_converters.dart';

Column buildUpperTexts(String city, DateTime dt, BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 35,
          ),
          Text(
            "$city",
            style: TextStyle(
                fontSize: 30,
                fontFamily: "Shabnam",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Text(
        "${AppLocalizations.of(context).translate(getDay(dt.weekday))}, ${AppLocalizations.of(context).translate(getMonth(dt.month))} ${dt.day}, ${dt.year}",
        style: TextStyle(
            fontSize: 20, fontFamily: "Shabnam", fontWeight: FontWeight.w800),
      ),
    ],
  );
}
