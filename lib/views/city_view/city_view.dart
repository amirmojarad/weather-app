import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icon.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/models/settings/settings.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/controllers/home_view_controller.dart';
import 'package:weather/views/city_view/widgets/lower_section.dart';
import 'package:weather/views/city_view/widgets/upper_section.dart';

class CityView extends StatefulWidget {
  Weather weather;
  ScrollController _controller;
  Settings settings;

  CityView(this.weather, this._controller, {this.settings});

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
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SvgPicture.asset(
              'assets/images/background-light.svg',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: device.width,
              height: device.height,
            ),
            Container(
              height: device.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCurrentData(context, controller.weather),
                  Padding(
                    padding: EdgeInsets.only(top: device.height/6),
                    child: LowerSection(
                        controller.weather, widget.settings, context),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
