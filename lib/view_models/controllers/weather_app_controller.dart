import 'package:sqflite/sqflite.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';

class WeatherAppController {
  final DatabaseHandler databaseHandler = DatabaseHandler();

  Future<DatabaseHandler> generateDB() async {
    await databaseHandler.generatePath();
    await databaseHandler.generateCities();
    return databaseHandler;
  }
}
