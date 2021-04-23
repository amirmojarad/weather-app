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
        border: Border.all(
          color: Theme.of(context).accentIconTheme.color,
          width: 0.5
        ),
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(29),
      ),
      width: device.width - 100,
      height: 40,
      child: Row(
        children: List.generate(
          3,
          (index) {
            return Expanded(
              child: Center(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
