import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/database_handler/city.dart';

Container buildBottomSheet(
    {BuildContext context, City city, Function setAsDefault, Function delete}) {
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
                Text(city.city, style: Theme.of(context).textTheme.bodyText1),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(city.country,
                      style: Theme.of(context).textTheme.headline5),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(width: device.width, child: Divider()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await setAsDefault();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Set As Default",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                  child: SizedBox(
                    width: device.width,
                    child: Divider(),
                    height: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await delete();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                        fontFamily:
                            Theme.of(context).textTheme.headline5.fontFamily,
                        fontWeight:
                            Theme.of(context).textTheme.headline5.fontWeight,
                      ),
                    ),
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
