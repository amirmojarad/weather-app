import 'package:flutter/material.dart';
import 'package:weather/view_models/controllers/home_view_controller.dart';
import 'package:weather/view_models/home_city/home_city.dart';

class HomeView extends StatefulWidget {
  ScrollController _controller;
  HomeCity homeCity;

  HomeView(this._controller, this.homeCity);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) return snapshot.data;
          return Center(
            child: Container(
              color: Colors.transparent,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff10BF79)),
              ),
            ),
          );
        },
        future: controller.getData(widget.homeCity.weather.lat,
            widget.homeCity.weather.lon, widget._controller),
      ),
    );
  }
}
