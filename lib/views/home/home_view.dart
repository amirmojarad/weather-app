import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/converters/date_converters.dart';
import 'package:weather/models/utils/device.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';
import 'package:weather/view_models/api_handler/api_utils.dart';

//TODO set color automata for an icon
class HomeView extends StatefulWidget {
  Weather weather;

  HomeView(this.weather);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    String city = widget.weather.timezone;
    city = city.substring(city.indexOf("/")).substring(1);
    var dt =
        DateTime.fromMillisecondsSinceEpoch(widget.weather.current.dt * 1000)
            .toLocal();
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: buildUpperTexts(city, dt),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: buildCardInfo(
                    widget.weather.current.temp,
                    widget.weather.current.feelsLike,
                    widget.weather.current.weather.icon,
                    widget.weather.current.weather.description),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "${AppLocalizations.of(context).translate("sunrise")}",
                          ),
                          Text("ASD"),
                        ],
                      ),
                    ],
                  ),
                  width: device.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffDBFFFB),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ],
          ),
        ),
        width: device.width,
        height: device.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffE7FFFA), Color(0xffF1FFFC)],
          ),
        ),
      ),
    );
  }

  Column buildUpperTexts(String city, DateTime dt) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 35,
            ),
            Text(
              "$city",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Shabnam",
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          "${AppLocalizations.of(context).translate(getDay(dt.weekday))}, ${AppLocalizations.of(context).translate(getMonth(dt.month))} ${dt.day}, ${dt.year}",
          style: TextStyle(
              fontSize: 20, fontFamily: "Shabnam", fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Container buildCardInfo(
      dynamic temp, dynamic feelsLike, String icon, String description) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            buildLeftSectionCard(temp, feelsLike),
            Column(
              children: [
                Image.network(
                  getIcons(icon),
                  color: Colors.yellow,
                  width: device.width / 4.5,
                ),
                Text(
                  "$description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
      width: device.width,
      height: device.height / 4,
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

  Column buildLeftSectionCard(dynamic temp, dynamic feelsLike) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${temp.toInt()}",
              style: TextStyle(fontSize: 80, color: Color(0xff00110C)),
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
        Text(
          "${AppLocalizations.of(context).translate("feels_like")}: ${feelsLike.toInt()}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
