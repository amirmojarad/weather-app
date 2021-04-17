import 'package:flutter/material.dart';
import 'package:weather/view_models/controllers/home_view_controller.dart';

class HomeView extends StatefulWidget {
  ScrollController _controller;

  HomeView(this._controller);

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
        future: controller.getData(48.8566, 2.3522, widget._controller),
      ),
    );
  }
}
