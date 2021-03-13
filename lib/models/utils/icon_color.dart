import 'package:flutter/material.dart';

Color getColor(String iconURL) {
  switch (iconURL) {
    case "01d":
    case "01n":
      return Colors.yellow;
    case "02d":
    case "02n":
      return Colors.orangeAccent.withOpacity(0.5);
    case "03d":
    case "03n":
    case "04d":
    case "04n":
      return Colors.white;
    case "50d":
      return Colors.grey;
    case "11d":
      return Colors.transparent;
    case "13d":
      return Colors.lightBlueAccent.withOpacity(0.8);
    default:
      return Colors.white;
  }
}
