import 'package:flutter/material.dart';

Column buildSunriseSunset(DateTime date, IconData icon, Color color) {
  return Column(
    children: [
      Icon(
        icon,
        color: color,
        size: 50,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          "${date.hour}:${date.minute}",
          style: TextStyle(
            fontSize: 23,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  );
}
