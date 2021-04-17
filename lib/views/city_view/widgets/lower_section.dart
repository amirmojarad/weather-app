import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather/models/api/hourly/data.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/converters/date_converters.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/api_handler/api_utils.dart';
import 'package:weather/view_models/controllers/lower_section_controller.dart';

class LowerSection extends StatefulWidget {
  Weather weather;

  LowerSection(this.weather);

  @override
  _LowerSectionState createState() => _LowerSectionState(weather);
}

class _LowerSectionState extends State<LowerSection> {
  Weather weather;
  LowerSectionController controller;

  _LowerSectionState(this.weather) {
    controller = LowerSectionController();
    controller.weather = weather;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              buildSection(
                  title: "Today",
                  onTap: () {
                    controller.selected = 1;
                  }),
              SizedBox(width: 20),
              buildSection(
                  title: "This Week",
                  onTap: () {
                    controller.selected = 2;
                  }),
              SizedBox(width: 20),
              buildSection(
                  title: "All",
                  onTap: () {
                    controller.selected = 3;
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
    );
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
            color:
                thisIndex == controller.selected ? Colors.black : Colors.grey,
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

  List<Widget> listGenerator(int length, dynamic list, String type) {
    return List.generate(length, (index) {
      if (type == "today")
        return buildTodayHour(list[index]);
      else
        return buildWeek(list[index]);
    });
  }

  List<Widget> buildAllSection() {
    List<Widget> result = [];

    // ---------------- Sunrise ---------------------//
    String sunrise = "";
    var sunriseDate = weather.current.sunrise as DateTime;
    sunrise = "${sunriseDate.hour}:${sunriseDate.minute}";
    result.add(buildAllInfo(
        data: sunrise, icon: WeatherIcons.wiSunrise, title: "Sunrise"));
    // ----------------Sunset-----------------------//
    String sunset = "";
    var sunsetDate = weather.current.sunset as DateTime;
    sunset = "${sunsetDate.hour}:${sunsetDate.minute}";
    result.add(buildAllInfo(
        data: sunset, icon: WeatherIcons.wiSunset, title: "Sunset"));
    // ----------------Clouds-----------------------//
    result.add(buildAllInfo(
        data: weather.current.clouds,
        icon: WeatherIcons.wiCloud,
        title: "Clouds"));
    return result;
  }

  List<Widget> makeList() {
    switch (controller.selected) {
      case 1:
        return listGenerator(
            weather.hourly.data.length, weather.hourly.data, "today");
      case 2:
        return listGenerator(
            weather.daily.days.length, weather.daily.days, "week");
      default:
        return buildAllSection();
    }
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
}
