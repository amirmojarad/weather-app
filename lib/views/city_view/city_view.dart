import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/controllers/home_view_controller.dart';
import 'package:weather/views/city_view/widgets/lower_section.dart';
import 'package:weather/views/city_view/widgets/upper_section.dart';
import 'package:weather/views/city_view/widgets/wave_generator.dart';

class CityView extends StatefulWidget {
  Weather weather;
  ScrollController _controller;

  CityView(this.weather, this._controller);

  @override
  _CityViewState createState() => _CityViewState(this.weather);
}

class _CityViewState extends State<CityView> {
  HomeViewController controller;
  Weather weather;

  _CityViewState(this.weather) {
    controller = HomeViewController();
    controller.weather = weather;
  }

  @override
  void dispose() {
    super.dispose();
  } // 1 today, 2 this week

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
            buildCurrentData(context, controller.weather),
            buildCard(
              config: CustomConfig(
                gradients: [
                  [Colors.blue, Color(0xff00EFF7)],
                  [Colors.blue[800], Color(0xff4BB8DF)],
                  [Color(0xff65CCCD), Color(0xff91FDFF)],
                  [Color(0xff0886FD), Color(0xff2A8FED)]
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.20, 0.23, 0.25, 0.30],
                // blur: _blur,
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
            ),
            LowerSection(controller.weather)
          ],
        ),
      ),
    );
  }
}
