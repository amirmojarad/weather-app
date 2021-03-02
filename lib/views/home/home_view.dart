import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/views/home/widgets/card_info.dart';
import 'package:weather/views/home/widgets/sections/humidity.dart';
import 'package:weather/views/home/widgets/sections/pressure.dart';
import 'package:weather/views/home/widgets/sections/wind_speed.dart';
import 'package:weather/views/home/widgets/upper_widgets.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';

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
                padding: const EdgeInsets.only(top: 32.0, bottom: 32),
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
                  aspectRatio: 2.2,
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
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 32, left: 10, right: 10),
                child: AspectRatio(
                  aspectRatio: 2,
                  child: Container(
                    child: WeekChart(),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 250)
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

class WeekChart extends StatelessWidget {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  WeekChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: false,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return AppLocalizations.of(context).translate("sat");
                case 2:
                  return 'Mon';
                case 3:
                  return 'Tue';
                case 4:
                  return 'Wed';
                case 5:
                  return 'Thu';
                case 6:
                  return 'Sat';
                case 7:
                  return "Fri";
              }
              return '';
            },
            margin: 8,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff67727d),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 10:
                  return '10';
                case 20:
                  return '20';
                case 30:
                  return '30';
                case 40:
                  return '40';
                case 50:
                  return '50';
              }
              return '';
            },
            reservedSize: 28,
            margin: 12,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 0,
        maxX: 8,
        minY: 0,
        maxY: 50,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(1, 1),
              FlSpot(2, 2),
              FlSpot(3, 3),
              FlSpot(4, 50),
              FlSpot(5, 5),
              FlSpot(6, 7),
              FlSpot(7, 20),
            ],
            isCurved: true,
            colors: gradientColors,
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
            ),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
