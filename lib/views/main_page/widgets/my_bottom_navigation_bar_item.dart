import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:weather/models/utils/device.dart';

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
                size: 40,
              ),
              currentIndex == index
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: device.width / 7,
                        height: 3,
                        color: Color(0xff00539C),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      width: device.width / 4,
      height: 75,
    );
  }
}
