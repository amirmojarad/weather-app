import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/utils/device.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SizedBox(
                width: device.width,
                child: Divider(),
                height: 0,
              ),
            ),
            // buildCard(
            //   config: CustomConfig(
            //     gradients: [
            //       [Color(0xff1D9AFF).withOpacity(0.9), Color(0xff1D9AFF).withOpacity(0.05)],
            //       [Color(0xff83B7FF), Color(0xff83B7FF)],
            //       [Color(0xff65CCCD), Color(0xff2C79E5)],
            //       [Color(0xffF1FFFC), Color(0xffF1FFFC)]
            //     ],
            //     durations: [35000, 19440, 10800, 6000],
            //     heightPercentages: [0.20, 0.23, 0.25, 0.30],
            //     // blur: _blur,
            //     gradientBegin: Alignment.bottomLeft,
            //     gradientEnd: Alignment.topRight,
            //   ),
            // ),
            LowerSection(controller.weather)
          ],
        ),
      ),
    );
  }
}
