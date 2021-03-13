import 'package:flutter/material.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';

String translate(String word, BuildContext context) {
  return AppLocalizations.of(context).translate(word);
}
