import 'package:flutter/material.dart';
import 'package:weather/models/api/hourly/data.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/models/utils/icon_color.dart';
import 'package:weather/view_models/api_handler/api_utils.dart';

Widget buildHourlyCard(HourlyData data) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${data.dt.hour}:${data.dt.minute}",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Center(
            child: Image.network(
              getIcons(
                data.weather.icon,
              ),
              width: device.width / 2,
              height: device.height / 10,
              color: getColor(data.weather.icon),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${data.temp.toInt()}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "o",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
      width: device.width / 4,
      height: device.height / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color(0xff006BB2),
            Color(0xff5006BB2).withOpacity(0.9),
            Color(0xff006BB2).withOpacity(0.6),
            // Color(0xff006BB2).withOpacity(0.3),
          ],
        ),
      ),
    ),
  );
}
