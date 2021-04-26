import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/api_handler/api_utils.dart';
import 'package:weather/views/utils/colors.dart' as colors;

Widget buildCurrentData(BuildContext context, Weather weather) {
  String getCityName() {
    String city = weather.timezone;
    city = city.substring(city.indexOf("/")).substring(1);
    return city;
  }

  return Container(
    color: Colors.transparent,
    child: Column(
      children: [
        Text(getCityName(), style: Theme.of(context).textTheme.headline4),
        Text(weather.current.weather.description,
            style: Theme.of(context).textTheme.subtitle2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weather.current.temp.toInt().toString(),
                style: Theme.of(context).textTheme.headline1),
            Text(
              "o",
              style: TextStyle(fontSize: 36, color: colors.kIcon2),
            )
          ],
        ),
        Icon(getIcon(weather.current.weather.icon),
            size: 80, color: colors.kIcon2),
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
          color: colors.kIcon2,
        ),
      ),
      SizedBox(height: 5),
      Text(
        title,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      SizedBox(height: 5),
      Text(
        "${value.toString()}$postFix",
        style: Theme.of(context).textTheme.caption,
      )
    ],
  );
}
