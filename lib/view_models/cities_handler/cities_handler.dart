import 'package:weather/models/cities/cities.dart';
import 'package:weather/view_models/cities_handler/file_handler.dart';

class CitiesHandler {
  Cities cities;
  FileHandler fileHandler;

  CitiesHandler() {
    this.fileHandler = FileHandler();
  }

  Future<void> load() async {
    try {
      Map<String, dynamic> json = await fileHandler.read();
      print("from load " + json.length.toString());
      if (json.length == 0)
        cities = Cities();
      else
        cities = Cities.fromJson(json);
    } catch (e) {
      cities = Cities();
      print(e);
    }
  }

  Future<void> save() async {
    await fileHandler.write(cities.toJson());
  }
}
