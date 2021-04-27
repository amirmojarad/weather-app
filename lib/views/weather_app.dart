import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/view_models/controllers/weather_app_controller.dart';
import 'package:weather/views/progressbars/welcome_progress.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';
import 'main_page/main_page.dart';
import 'package:weather/views/utils/fonts.dart' as fonts;
import 'package:weather/views/utils/colors.dart' as colors;

//TODO card fonts change
//Todo colors
//Todo hide bottom bar and disable functionality
//TODO add main Colors
//Todo delete About me section in driver
//Todo better search function and showing result
class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  WeatherAppController controller = WeatherAppController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Todo Dark theme
      darkTheme: ThemeData(),
      theme: ThemeData(
        backgroundColor: colors.kBackgroundColor,
        focusColor: colors.kFocus,
        iconTheme: IconThemeData(color: colors.kIcon1),
        dividerColor: colors.kDivider,
        errorColor: colors.kError,
        accentIconTheme:
            IconThemeData(color: colors.kAccentIconColor, size: 20),
        primaryIconTheme: IconThemeData(color: colors.kIcon1, size: 24),
        // accentColor: Color(0xff78D9EA),
        accentColor: colors.kAccentColor,
        bottomAppBarColor: colors.kBottomBarColor,
        textTheme: TextTheme(
          headline1: fonts.headline1,
          headline2: fonts.headline2,
          headline3: fonts.headline3,
          headline4: fonts.headline4,
          headline5: fonts.headline5,
          headline6: fonts.headline6,
          button: fonts.button,
          bodyText1: fonts.bodyText1,
          bodyText2: fonts.bodyText2,
          subtitle1: fonts.subtitle1,
          subtitle2: fonts.subtitle2,
          caption: fonts.caption,
        ),
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fa', 'FA'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: controller.generateInformation(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return MainPage(
              snapshot.data['databaseHandler'],
              snapshot.data['citiesHandler'],
              snapshot.data['homeCity'],
              snapshot.data['settings'],
            );
          else {
            return Scaffold(
              body: Container(
                color: Theme.of(context).backgroundColor,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowUp(
                        child: Center(
                            child: Image.asset('assets/launcher/icon.png',
                                width: 200, height: 200)),
                        delay: 1,
                      ),
                      ShowUp(
                        child: Center(child: Text("Welcome To Weather App!")),
                        delay: 3,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
