import 'package:flutter/material.dart';
import 'package:weather/models/api/weather.dart';
import 'package:weather/view_models/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// London lat & lon = 51.5074  0.1278
class _HomePageState extends State<HomePage> {
  HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffE7FFFA), Color(0xffF1FFFC)],
        ),
      ),
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
        future: controller.getData(25.2048, 55.2708),
      ),
    );
  }
}
