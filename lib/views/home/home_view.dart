import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather/models/api/hourly/data.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/converters/date_converters.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/api_handler/api_utils.dart';
import 'package:weather/view_models/controllers/home_view_controller.dart';

class HomeView extends StatefulWidget {
  Weather weather;
  ScrollController _controller;

  HomeView(this.weather, this._controller);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewController controller;
  int selected = 1;

  // 1 today, 2 this week
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
      child: SingleChildScrollView(
        controller: widget._controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCurrentData(context),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      buildSection(
                          title: "Today",
                          onTap: () {
                            selected = 1;
                          }),
                      SizedBox(width: 20),
                      buildSection(
                          title: "This Week",
                          onTap: () {
                            selected = 2;
                          }),
                      SizedBox(width: 20),
                      buildSection(
                          title: "All",
                          onTap: () {
                            selected = 3;
                          }),
                    ],
                  ),
                ),
                SizedBox(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    width: device.width),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: makeList()),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAllInfo({@required dynamic data, IconData icon, String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 5),
            child: Icon(icon),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              data.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildAllSection() {
    List<Widget> result = [];

    // ---------------- Sunrise ---------------------//
    String sunrise = "";
    var sunriseDate = controller.weather.current.sunrise as DateTime;
    sunrise = "${sunriseDate.hour}:${sunriseDate.minute}";
    result.add(buildAllInfo(
        data: sunrise, icon: WeatherIcons.wiSunrise, title: "Sunrise"));
    // ----------------Sunset-----------------------//
    String sunset = "";
    var sunsetDate = controller.weather.current.sunset as DateTime;
    sunset = "${sunsetDate.hour}:${sunsetDate.minute}";
    result.add(buildAllInfo(
        data: sunset, icon: WeatherIcons.wiSunset, title: "Sunset"));
    // ----------------Clouds-----------------------//
    result.add(buildAllInfo(
        data: controller.weather.current.clouds,
        icon: WeatherIcons.wiCloud,
        title: "Clouds"));
    return result;
  }

  List<Widget> makeList() {
    switch (selected) {
      case 1:
        return listGenerator(controller.weather.hourly.data.length,
            controller.weather.hourly.data, "today");
      case 2:
        return listGenerator(controller.weather.daily.days.length,
            controller.weather.daily.days, "week");
      default:
        return buildAllSection();
    }
  }

  List<Widget> listGenerator(int length, dynamic list, String type) {
    return List.generate(length, (index) {
      if (type == "today")
        return buildTodayHour(list[index]);
      else
        return buildWeek(list[index]);
    });
  }

  Material buildSection({String title, Function onTap}) {
    int thisIndex = title.toLowerCase() == "today" ? 1 : 2;
    switch (title.toLowerCase()) {
      case 'today':
        thisIndex = 1;
        break;
      case 'this week':
        thisIndex = 2;
        break;
      case 'all':
        thisIndex = 3;
        break;
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          setState(() {
            onTap();
          });
        },
        child: Text(
          title,
          style: TextStyle(
            color: thisIndex == selected ? Colors.black : Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  int getAverage(double min, double max) {
    return (min + max) ~/ 2;
  }

  Widget buildWeek(dynamic data) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Column(
        children: [
          Text(
              (data.dt as DateTime).day != DateTime.now().day
                  ? "${(data.dt as DateTime).day} ${getMonth((data.dt as DateTime).month)}"
                  : "Today",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: getIcon(data.weather.dayWeather[0].icon, 25)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${getAverage(data.temp.min, data.temp.max)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1.0),
                child: Text(
                  "o",
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "${data.weather.dayWeather[0].description}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTodayHour(HourlyData data) {
    if (data.dt.hour < DateTime.now().hour || data.dt.day != DateTime.now().day)
      return Container();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          Text(
              (data.dt as DateTime).hour != DateTime.now().hour
                  ? "${(data.dt as DateTime).hour}:00"
                  : "Now",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: getIcon(data.weather.icon, 25)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${data.temp.toInt()}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1.0),
                child: Text(
                  "o",
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "${data.weather.description}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCurrentData(BuildContext context) {
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
        padding: const EdgeInsets.only(top: 10.0, bottom: 38.0),
        child: Column(
          children: [
            Text(controller.getCityName(),
                style: Theme.of(context).textTheme.bodyText2),
            Text(controller.weather.current.weather.description,
                style: Theme.of(context).textTheme.bodyText1),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.weather.current.temp.toInt().toString(),
                      style:
                          TextStyle(fontSize: 72, fontWeight: FontWeight.w500)),
                  Text(
                    "o",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            getIcon(controller.weather.current.weather.icon, 80),
            // Image.network(
            //   getIcons(controller.weather.current.weather.icon),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: buildTag(
                        context,
                        "Humidity",
                        WeatherIcons.wiHumidity,
                        controller.weather.current.humidity),
                  ),
                  Expanded(
                    child: buildTag(context, "Speed", WeatherIcons.wiStrongWind,
                        controller.weather.current.windSpeed),
                  ),
                  Expanded(
                    child: buildTag(
                        context,
                        "Pressure",
                        WeatherIcons.wiBarometer,
                        controller.weather.current.pressure),
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
}
