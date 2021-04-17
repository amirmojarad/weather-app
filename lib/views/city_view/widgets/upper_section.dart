import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather/models/api/hourly/data.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/api_handler/api_utils.dart';



Widget buildCurrentData(BuildContext context, Weather weather) {

  String getCityName() {
    String city = weather.timezone;
    city = city.substring(city.indexOf("/")).substring(1);
    return city;
  }

  DateTime getCurrentTime() {
    return weather.hourly.dt as DateTime;
  }

  String getTime(HourlyData data) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(data.dt);
    return time.toString();
  }
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff1D9AFF),
        Color(0xff1D9AFF).withOpacity(0.9),
        Color(0xff1D9AFF).withOpacity(0.8),
        Color(0xff1D9AFF).withOpacity(0.7),
        Color(0xff1D9AFF).withOpacity(0.6),
        Color(0xff1D9AFF).withOpacity(0.5),
        Color(0xff1D9AFF).withOpacity(0.4),
        Color(0xff1D9AFF).withOpacity(0.3),
        Color(0xff1D9AFF).withOpacity(0.2),
        Color(0xff1D9AFF).withOpacity(0.1),
        Color(0xff1D9AFF).withOpacity(0.05),
      ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Column(
        children: [
          Text(getCityName(),
              style: Theme.of(context).textTheme.bodyText2),
          Text(weather.current.weather.description,
              style: Theme.of(context).textTheme.bodyText1),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weather.current.temp.toInt().toString(),
                    style:
                        TextStyle(fontSize: 72, fontWeight: FontWeight.w500)),
                Text(
                  "o",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          getIcon(weather.current.weather.icon, 80),
          // Image.network(
          //   getIcons(controller.weather.current.weather.icon),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: buildTag(context, "Humidity", WeatherIcons.wiHumidity,
                      weather.current.humidity),
                ),
                Expanded(
                  child: buildTag(context, "Speed", WeatherIcons.wiStrongWind,
                      weather.current.windSpeed),
                ),
                Expanded(
                  child: buildTag(context, "Pressure", WeatherIcons.wiBarometer,
                      weather.current.pressure),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Column buildTag(
    BuildContext context, String title, IconData icon, dynamic value) {
  var postFix;
  switch (title.toLowerCase()) {
    case "speed":
      postFix = "m/s";
      break;

    case "humidity":
      postFix = "%";

      break;
    case "pressure":
      postFix = "hPa";
      break;
  }
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: Icon(
          icon,
          size: 28,
        ),
      ),
      SizedBox(height: 5),
      Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 5),
      Text(
        "${value.toString()}$postFix",
        style: Theme.of(context).textTheme.bodyText1,
      )
    ],
  );
}
