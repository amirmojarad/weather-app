import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  int index = 0;

  MyBottomNavigationBar(this.index);

  @override
  _MyBottomNavigationBarState createState() =>
      _MyBottomNavigationBarState(this.index);
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _index = 0;

  _MyBottomNavigationBarState(this._index);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          _index = index;
        });
      },
      elevation: 30,
      backgroundColor: Colors.transparent,
      iconSize: 30,
      selectedIconTheme: IconThemeData(
        color: Color(0xff006F9E),
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xff006F9E).withOpacity(0.5),
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Icon(
                Icons.search,
              ),
              _index == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          label: "ASD",
        ),
        BottomNavigationBarItem(
          label: "Home",
          icon: Column(
            children: [
              Icon(
                Icons.location_city,
              ),
              _index == 1
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ],
      currentIndex: _index,
    );
  }
}
