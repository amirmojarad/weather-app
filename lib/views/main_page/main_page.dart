import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:weather/models/settings/settings.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/controllers/main_page_controller.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';
import 'package:weather/view_models/home_city/home_city.dart';
import 'package:weather/views/cities_view/cities_view.dart';
import 'package:weather/views/city_view/home_view.dart';
import 'package:weather/views/my_flutter_app_icons.dart';
import 'package:weather/views/search_view/search_view_vertical.dart';

import 'widgets/my_app_bar.dart';
import 'widgets/my_bottom_navigation_bar.dart';
import 'widgets/my_drawer.dart';

class MainPage extends StatefulWidget {
  DatabaseHandler databaseHandler;
  CitiesHandler citiesHandler;
  HomeCity homeCity;
  Settings settings;

  MainPage(
    this.databaseHandler,
    this.citiesHandler,
    this.homeCity,
    this.settings,
  );

  @override
  _MainPageState createState() =>
      _MainPageState(this.databaseHandler, this.citiesHandler);
}

class _MainPageState extends State<MainPage> {
  MainPageController controller;
  ScrollController _controller;
  DatabaseHandler databaseHandler;
  CitiesHandler citiesHandler;

  _MainPageState(this.databaseHandler, this.citiesHandler);

  onPageChange(int value) {
    setState(() {
      controller.index = value;
    });
  }

  bool show = true;

  _scrollFunction() {
    if (_controller.offset >= 0 && _controller.offset <= 10)
      setState(() {
        show = true;
      });
    else {
      setState(() {
        show = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = MainPageController();
    _controller = ScrollController();
    _controller.addListener(_scrollFunction);
  }

  @override
  Widget build(BuildContext context) {
    device = Device(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            height: device.height,
            child: buildDrawer(context, stateUpdated: () {
              setState(() {});
            }, settings: widget.settings),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(60), child: MyAppBar()),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: controller.controller,
            onPageChanged: (value) => onPageChange(value),
            children: [
              HomeView(_controller, widget.homeCity, widget.settings),
              SearchViewVertical(
                  _controller, databaseHandler, citiesHandler, widget.homeCity),
              CitiesView(_controller, citiesHandler, widget.homeCity),
            ],
          ),
          AnimatedOpacity(
            opacity: show ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: BottomNavBar(
                currentIndex: controller.index,
                controller: controller.controller,
                items: [
                  LineIcons.home,
                  MyFlutterApp.combined_shape_1,
                  MyFlutterApp.like,
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
