import 'package:connectivity/connectivity.dart';
import 'package:weather/models/settings/settings.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';
import 'package:weather/view_models/home_city/home_city.dart';

class WeatherAppController {
  final DatabaseHandler databaseHandler = DatabaseHandler();
  CitiesHandler cities = CitiesHandler();
  HomeCity homeCity = HomeCity();
  final Settings settings = Settings();

  Future<void> saveCities() async {
    await this.cities.save();
  }

  Future<Map<String, dynamic>> generateInformation() async {
    await databaseHandler.generatePath();
    await databaseHandler.generateCities();
    await cities.load();
    //TODO cache home city
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      try {
        await homeCity.loadHome();
      } catch (e) {
        print(e);
      }
      return {
        'databaseHandler': databaseHandler,
        'citiesHandler': cities,
        'homeCity': homeCity,
        'settings': settings
      };
    } else {
      return {
        'databaseHandler': databaseHandler,
        'citiesHandler': cities,
        'homeCity': null,
        'settings': settings
      };
    }
  }
}
