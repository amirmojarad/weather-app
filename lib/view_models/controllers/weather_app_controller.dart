import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';

class WeatherAppController {
  final DatabaseHandler databaseHandler = DatabaseHandler();
  CitiesHandler cities = CitiesHandler();

  Future<void> saveCities() async {
    await this.cities.save();
  }

  Future<Map<String, dynamic>> generateInformation() async {
    await databaseHandler.generatePath();
    await databaseHandler.generateCities();
    await cities.load();
    return {'databaseHandler': databaseHandler, 'citiesHandler': cities};
  }
}
