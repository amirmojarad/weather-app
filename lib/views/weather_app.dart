import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/view_models/controllers/weather_app_controller.dart';
import 'package:weather/views/progressbars/welcome_progress.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';
import 'main_page/main_page.dart';
import 'package:weather/views/utils/fonts.dart' as fonts;
import 'package:weather/views/utils/colors.dart' as colors;

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  WeatherAppController controller = WeatherAppController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: colors.kBackgroundColor,
        focusColor: colors.kFocus,
        iconTheme: IconThemeData(color: colors.kIcon),
        accentIconTheme: IconThemeData(color: colors.kAccentIconColor),
        dividerColor: colors.kDivider,
        errorColor: colors.kError,
        // accentColor: Color(0xff78D9EA),
        accentColor: Colors.red,
        textTheme: TextTheme(
            headline1: fonts.headline1,
            headline2: fonts.headline2,
            headline3: fonts.headline3,
            button: fonts.button,
            bodyText1: fonts.bodyText1,
            bodyText2: fonts.bodyText2,
            headline4: fonts.headline4),
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
          return snapshot.hasData
              ? MainPage(snapshot.data['databaseHandler'],
                  snapshot.data['citiesHandler'], snapshot.data['homeCity'])
              : Center(
                  child: welcomeProgress(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height));
        },
      ),
    );
  }
}
