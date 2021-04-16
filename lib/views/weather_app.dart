import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/view_models/controllers/weather_app_controller.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';
import 'package:weather/views/progressbars/welcome_progress.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';
import 'main_page/main_page.dart';

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
        backgroundColor: Colors.yellow,
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],
        // accentColor: Colors.cyan[600],

        // Define the default font family.
        // fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(
              fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w600),
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
          return snapshot.hasData
              ? MainPage(snapshot.data['databaseHandler'],
                  snapshot.data['citiesHandler'])
              : Center(
                  child: welcomeProgress(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height));
        },
      ),
    );
  }
}
