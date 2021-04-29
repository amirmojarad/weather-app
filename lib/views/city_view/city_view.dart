import 'package:flutter/material.dart';
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
        controller: controller.scrollController,
        child: Column(
          // alignment: Alignment.bottomCenter,
          children: [
            ClipPath(
              clipper: ClipPathClass(),
              child: Container(
                color: Theme.of(context).accentColor,
                width: device.width,
                height: device.height <= 600
                    ? device.height / 1.4
                    : device.height / 1.5,
                child: Padding(
                  padding: EdgeInsets.only(top: device.height / 50),
                  child: buildCurrentData(context, controller.weather),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).backgroundColor,
              child: LowerSection(controller.weather, widget.settings, context),
            ),
            device.height <= 600
                ? SizedBox(
                    height: 30,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
