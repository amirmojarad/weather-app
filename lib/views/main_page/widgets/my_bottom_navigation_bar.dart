import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';

import 'my_bottom_navigation_bar_item.dart';

class BottomNavBar extends StatefulWidget {
  int currentIndex;
  List<IconData> items;
  PageController controller;

  BottomNavBar({
    this.currentIndex,
    @required this.controller,
    @required this.items,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<BottomNavBarItem> items = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff94FDFF),
          Color(0xff5CF9FB),
          Color(0xff5CF9FB),
        ]),
        borderRadius: BorderRadius.circular(29),
      ),
      width: device.width - 100,
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Center(
            child: BottomNavBarItem(
              currentIndex: widget.currentIndex,
              index: index,
              data: widget.items[index],
              onTap: () {
                setState(
                  () {
                    widget.controller.jumpToPage(index);
                    widget.currentIndex = index;
                  },
                );
              },
            ),
          );
        },
        itemCount: widget.items.length,
      ),
    );
  }
}
