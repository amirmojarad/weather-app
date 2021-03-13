import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/models/utils/icon_color.dart';
import 'package:weather/view_models/api_handler/api_utils.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';

Container buildCardInfo(dynamic temp, dynamic feelsLike, String icon,
    String description, BuildContext context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Image.network(
              getIcons(icon),
              color: getColor(icon),
            ),
            Text(
              "$description",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          width: device.width - 380,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: buildLeftSectionCard(temp, feelsLike, context),
        ),
      ],
    ),
    width: device.width,
    height: device.height / 1.2,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 16.0,
        ),
      ],
      borderRadius: BorderRadius.circular(18),
      gradient: LinearGradient(
        colors: [
          Color(0xff97FFE0),
          Color(0xff5AEEC2),
          Color(0xff25E1A9),
        ],
      ),
    ),
  );
}

Column buildLeftSectionCard(
    dynamic temp, dynamic feelsLike, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${temp.toInt()}",
            style: TextStyle(fontSize: 75, color: Color(0xff00110C)),
          ),
          SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 4),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 7,
      ),
      Text(
        "${AppLocalizations.of(context).translate("feels_like")}: ${feelsLike.toInt()}",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      )
    ],
  );
}
