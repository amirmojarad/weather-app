import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/views/home/widgets/card_info.dart';
import 'package:weather/views/home/widgets/sections/humidity.dart';
import 'package:weather/views/home/widgets/sections/pressure.dart';
import 'package:weather/views/home/widgets/sections/wind_speed.dart';
import 'package:weather/views/home/widgets/upper_widgets.dart';

import 'widgets/sections/info_tags.dart';
import 'widgets/sections/sunrise_sunset.dart';

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
    var sunrise = DateTime.fromMillisecondsSinceEpoch(
            widget.weather.current.sunrise * 1000)
        .toLocal();

    var sunset = DateTime.fromMillisecondsSinceEpoch(
            widget.weather.current.sunset * 1000)
        .toLocal();
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
                padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                child: AspectRatio(
                  aspectRatio: 5,
                  child: Center(
                    child: buildUpperTexts(city, dt, context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: AspectRatio(
                  aspectRatio: 2.5,
                  child: Center(
                    child: buildCardInfo(
                      widget.weather.current.temp,
                      widget.weather.current.feelsLike,
                      widget.weather.current.weather.icon,
                      widget.weather.current.weather.description,
                      context,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 5, right: 5),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Center(
                            child: Row(
                              children: [
                                buildPressure(widget.weather.current.pressure,
                                    "pressure", context),
                                SizedBox(width: 20),
                                buildWindSpeed(widget.weather.current.windSpeed,
                                    "wind_speed", context),
                                SizedBox(width: 20),
                                buildHumidity(widget.weather.current.humidity,
                                    "humidity", context),
                                SizedBox(width: 20),
                                buildInfoTags(
                                    widget.weather.current.uvi, "uvi", context),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            buildSunriseSunset(
                              sunrise,
                              Icons.wb_sunny_outlined,
                              Colors.yellow,
                            ),
                            SizedBox(
                              width: device.width - 150,
                            ),
                            buildSunriseSunset(
                              sunset,
                              Icons.nightlight_round,
                              Colors.blue,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  width: device.width,
                  height: device.height / 3,
                  decoration: BoxDecoration(
                    color: Color(0xffDBFFFB),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              )
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
}
