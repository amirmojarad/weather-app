import 'package:flutter/material.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';

Column buildHumidity(dynamic value, String title, BuildContext context) {
  return Column(
    children: [
      Text(
        "${AppLocalizations.of(context).translate(title)}",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.3)),
      ),
      SizedBox(height: 10),
      Text(
        "${value}%",
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
  );
}
