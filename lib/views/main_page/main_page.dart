import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/views/cities_view/cities_view.dart';
import 'package:weather/views/search_view/search_view_horizontal.dart';
import 'package:weather/views/search_view/search_view_vertical.dart';

import 'widgets/my_app_bar.dart';
import 'widgets/my_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    device = Device(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return Scaffold(
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: device.width - 100,
            height: device.height / 10,
            decoration: BoxDecoration(
              color: Color(0xff4AF8F8),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          MyBottomNavigationBar(index)
        ],
      ),
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(60), child: MyAppBar()),
      body: PageView(
        controller: controller,
        children: [
          OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? SearchViewVertical()
                  : SearchViewHorizontal();
            },
          ),
          CitiesView(),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
