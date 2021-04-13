import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';

Widget welcomeProgress(double width, double height) {
  return Scaffold(
    body: Container(
      color: Colors.white,
      width: width,
      height: height,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: LinearProgressIndicator(
            backgroundColor: Colors.blue,
            valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
          ),
        ),
      ),
    ),
  );
}
