import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';
import 'package:weather/views/weather_app.dart';

void main() {
  runApp(WeatherApp());
}

//
class TestMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: GestureDetector(
              onTap: () async {},
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text("TADF"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
