import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/device.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';

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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: buildCardInfo(widget.weather.current.temp,
                    widget.weather.current.feelsLike),
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

  Container buildCardInfo(double temp, double feelsLike) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
        ),
      ),
      width: device.width,
      height: device.height / 4,
      decoration: BoxDecoration(
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
}
