import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/controllers/main_page_controller.dart';
import 'package:weather/views/cities_view/cities_view.dart';
import 'package:weather/views/home/home.dart';
import 'package:weather/views/search_view/search_view_vertical.dart';

import 'widgets/my_app_bar.dart';
import 'widgets/my_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPageController controller;
  ScrollController _controller;

  onPageChange(int value) {
    setState(() {
      controller.index = value;
    });
  }

  bool show = true;

  _scrollFunction() {
    if (_controller.offset == 0)
      show = true;
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
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(60), child: MyAppBar()),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: controller.controller,
            onPageChanged: (value) => onPageChange(value),
            children: [
              HomePage(_controller),
              SearchViewVertical(),
              CitiesView(),
            ],
          ),
          show
              ? Padding(
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
                )
              : Container(),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
