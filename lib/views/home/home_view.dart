import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/localizations/translate.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/controllers/home_view_controller.dart';
import 'package:weather/views/home/widgets/card_info.dart';
import 'package:weather/views/home/widgets/sections/humidity.dart';
import 'package:weather/views/home/widgets/sections/pressure.dart';
import 'package:weather/views/home/widgets/sections/wind_speed.dart';
import 'package:weather/views/home/widgets/upper_widgets.dart';

import 'widgets/sections/info_tags.dart';
import 'widgets/sections/sunrise_sunset.dart';
import 'widgets/sections/weekly_chart.dart';

//TODO set color automata for an icon
class HomeView extends StatefulWidget {
  Weather weather;
  ScrollController _controller;

  HomeView(this.weather, this._controller);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeViewController(
      weather: widget.weather,
      scrollController: widget._controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32),
                child: AspectRatio(
                  aspectRatio: 5,
                  child: Center(
                    child: buildUpperTexts(controller.getCityName(),
                        controller.weather.current.dt, context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: Center(
                    child: buildCardInfo(
                      controller.weather.current.temp,
                      controller.weather.current.feelsLike,
                      controller.weather.current.weather.icon,
                      controller.weather.current.weather.description,
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
                                buildPressure(
                                    controller.weather.current.pressure,
                                    "pressure",
                                    context),
                                SizedBox(width: 20),
                                buildWindSpeed(
                                    controller.weather.current.windSpeed,
                                    "wind_speed",
                                    context),
                                SizedBox(width: 20),
                                buildHumidity(
                                    controller.weather.current.humidity,
                                    "humidity",
                                    context),
                                SizedBox(width: 20),
                                buildInfoTags(controller.weather.current.uvi,
                                    "uvi", context),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            buildSunriseSunset(
                              controller.weather.current.sunrise,
                              Icons.wb_sunny_outlined,
                              Colors.yellow,
                            ),
                            SizedBox(
                              width: device.width - 180,
                            ),
                            buildSunriseSunset(
                              controller.weather.current.sunset,
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
                ),
              ),
              SizedBox(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                width: device.width - 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 10),
                    child: Text(
                      translate("next_24_hour", context),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.generateCard(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                width: device.width - 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 10, bottom: 20),
                    child: Text(
                      "Weekly",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 32, left: 0, right: 20),
                    child: AspectRatio(
                      aspectRatio: 2,
                      child: WeekChart(
                        daily: this.controller.weather.daily,
                      ),
                    ),
                  ),
                ],
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
}
