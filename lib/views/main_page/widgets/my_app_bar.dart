import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/models/utils/device.dart';

class MyAppBar extends StatelessWidget {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      actions: [
        IconButton(
          icon: Icon(Icons.info_outline,
              color: Theme.of(context).accentIconTheme.color, size: 24,),
          onPressed: () {
            showDialog(
                barrierColor: Colors.white.withOpacity(0.6),
                useSafeArea: true,
                builder: (BuildContext context) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "About Application",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff2CD1CC),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Made with 💙 by amir mojarad",
                                style: TextStyle(fontSize: 20),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildSocialMedias(
                                      icon: LineIcons.github,
                                      url: "https://github.com/amirmojarad"),
                                  buildSocialMedias(
                                      icon: LineIcons.twitter,
                                      url: "https://twitter.com/AmirMojarad",
                                      color: Colors.blue),
                                  buildSocialMedias(
                                      icon: LineIcons.instagram,
                                      url:
                                          "https://www.instagram.com/amirmjrd/",
                                      color: Colors.pinkAccent),
                                  buildSocialMedias(
                                      icon: LineIcons.linkedin,
                                      url: "www.linkedin.com/in/amirmojarad",
                                      color: Colors.blue),
                                  IconButton(
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: 'amirmojarad13@gmail.com'));
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                          width: device.width,
                          height: 400,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black,
                                  offset: Offset(1, 7))
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                context: context);
          },
        ),
      ],
      // elevation: 5,
      title: Text("Weather App", style: Theme.of(context).textTheme.headline1),
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
