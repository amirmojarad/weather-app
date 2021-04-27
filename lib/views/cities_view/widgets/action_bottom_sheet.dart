import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/database_handler/city.dart';

Container buildBottomSheet(
    {BuildContext context,
    City city,
    Function setAsDefault,
    Function delete,
    Function setMainState}) {
  return Container(
    width: device.width,
    height: device.height / 5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      color: Theme.of(context).backgroundColor,
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(city.city,
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(city.country,
                      style: Theme.of(context).textTheme.headline6),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SizedBox(width: device.width, child: Divider()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    FutureBuilder(
                      future: setAsDefault(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Container(
                              color: Colors.white,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        return null;
                      },
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Set As Default",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
