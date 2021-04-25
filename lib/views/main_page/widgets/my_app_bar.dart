import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppBar extends StatelessWidget {
  Function function;

  MyAppBar({this.function});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text("Weather App", style: Theme.of(context).textTheme.headline5),
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
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
