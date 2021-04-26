import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/models/settings/settings.dart';
import 'package:weather/models/utils/device.dart';

Widget buildDrawer(BuildContext context,
    {Function stateUpdated, Settings settings}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 64,
      ),
      buildChangeTheme(stateUpdated, "Dark Theme"),
      Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32.0),
        child: SizedBox(width: device.width, child: Divider()),
      ),
      // buildDrawerItem(stateUpdated, "Show Minutely", settings),
      Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32.0),
        child: SizedBox(width: device.width, child: Divider()),
      ),
      Spacer(),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: SizedBox(
          child: Divider(),
          width: device.width,
        ),
      ),
      Text(
        "Made with 💙 by amir mojarad",
        style: Theme.of(context).textTheme.headline6,
      ),
      Row(
        children: [
          Expanded(
            child: buildSocialMedias(
                icon: LineIcons.github, url: "https://github.com/amirmojarad"),
          ),
          Expanded(
            child: buildSocialMedias(
                icon: LineIcons.twitter,
                url: "https://twitter.com/AmirMojarad",
                color: Colors.blue),
          ),
          Expanded(
            child: buildSocialMedias(
                icon: LineIcons.instagram,
                url: "https://www.instagram.com/amirmjrd/",
                color: Colors.pinkAccent),
          ),
          Expanded(
            child: buildSocialMedias(
                icon: LineIcons.linkedin,
                url: "www.linkedin.com/in/amirmojarad",
                color: Colors.blue),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.email,
                color: Colors.red,
              ),
              onPressed: () {
                Clipboard.setData(
                    ClipboardData(text: 'amirmojarad13@gmail.com'));
              },
            ),
          )
        ],
      ),
    ],
  );
}

Padding buildDrawerItem(
    Function stateUpdated, String title, Settings settings) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Row(
      children: [
        Text(title),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Switch(
            value: settings.showMinutely,
            onChanged: (value) async {
              settings.showMinutely = value;
              await settings.saveChanges();
              stateUpdated();
            },
          ),
        ),
      ],
    ),
  );
}

Padding buildChangeTheme(Function stateUpdated, String title) {
  bool isSwitched = false;
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            decoration: TextDecoration.lineThrough,
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Switch(
            value: isSwitched,
            onChanged: (value) {
              //TODO add dark theme
              // isSwitched = value;
              // stateUpdated();
            },
          ),
        ),
      ],
    ),
  );
}

IconButton buildSocialMedias(
    {@required String url,
    @required IconData icon,
    Color color = Colors.black}) {
  return IconButton(
    icon: Icon(
      icon,
      size: 35,
      color: color,
    ),
    onPressed: () {
      _launchURL(url);
    },
  );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
