import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:weather/models/localizations/app_localizations.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/controllers/main_page_controller.dart';
import 'package:weather/views/cities_view/cities_view.dart';
import 'package:weather/views/home/home.dart';
import 'package:weather/views/search_view/search_view_horizontal.dart';
import 'package:weather/views/search_view/search_view_vertical.dart';

import 'widgets/my_app_bar.dart';
import 'widgets/my_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPageController controller;

  onPageChange(int value) {
    setState(() {
      controller.index = value;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = MainPageController();
  }

  @override
  Widget build(BuildContext context) {
    device = Device(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
    return Scaffold(
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(60), child: MyAppBar()),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: controller.controller,
            onPageChanged: (value) => onPageChange(value),
            children: [
              HomePage(),
              SearchViewVertical(),
              CitiesView(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: BottomNavBar(
              currentIndex: controller.index,
              controller: controller.controller,
              items: [
                LineIcons.home,
                LineIcons.search,
                LineIcons.city,
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
