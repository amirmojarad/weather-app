import 'package:weather/models/cities/cities.dart';
import 'package:weather/view_models/cities_handler/file_handler.dart';
import 'package:weather/view_models/database_handler/city.dart';

class CitiesHandler {
  Cities cities;
  FileHandler fileHandler;

  CitiesHandler() {
    this.fileHandler = FileHandler('cities');
  }

  Future<void> load() async {
    try {
      Map<String, dynamic> json = await fileHandler.read();
      if (json.length == 0)
        cities = Cities();
      else
        cities = Cities.fromJson(json);
    } catch (e) {
      cities = Cities();
    }
  }

  int compare(City first, City second) {
    return first.city.compareTo(second.city);
  }

  Future<void> save() async {
    cities.cities.sort(compare);
    await fileHandler.write(cities.toJson());
  }
}
