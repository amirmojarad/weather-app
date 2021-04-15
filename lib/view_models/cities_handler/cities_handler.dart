import 'package:weather/models/cities/cities.dart';
import 'package:weather/view_models/cities_handler/file_handler.dart';

class CitiesHandler {
  Cities cities;
  FileHandler fileHandler;

  CitiesHandler(this.cities) {
    this.fileHandler = FileHandler();
  }

  void load() async {
    cities = Cities.fromJson(await fileHandler.read());
  }

  void save() async {
    await fileHandler.write(cities.toJson());
  }
}
