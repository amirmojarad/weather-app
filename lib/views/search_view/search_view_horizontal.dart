import 'package:flutter/material.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';

class SearchViewHorizontal extends StatefulWidget {
  @override
  _SearchViewHorizontalState createState() => _SearchViewHorizontalState();
}

class _SearchViewHorizontalState extends State<SearchViewHorizontal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child:
          Center(child: Text(AppLocalizations.of(context).translate("hello"))),
    ));
  }
}
