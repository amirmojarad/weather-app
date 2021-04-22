import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/views/utils/colors.dart' as colors;

class BottomNavBarItem extends StatelessWidget {
  IconData data;
  Function onTap;
  int index;
  int currentIndex;

  BottomNavBarItem({
    Key key,
    @required this.data,
    @required this.index,
    @required this.onTap,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(28), right: Radius.circular(28)),
        child: InkWell(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(28), right: Radius.circular(28)),
          onTap: onTap,
          splashColor: Colors.white.withOpacity(0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LineIcon(
                data,
                size: 25,
              ),
              currentIndex == index
                  ? Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colors.kDot,
                            borderRadius: BorderRadius.circular(25)),
                        width: 5,
                        height: 5,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      width: device.width / 4,
      height: 40,
    );
  }
}
