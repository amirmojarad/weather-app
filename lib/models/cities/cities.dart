import 'package:weather/view_models/database_handler/city.dart';

class Cities {
  List<City> cities;

  Cities() {
    this.cities = [];
  }

  Map<String, dynamic> toJson() {
    Map<String, List> json = {'cities': cities};
    return json;
  }

  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);
}

Cities _$CitiesFromJson(Map<String, dynamic> json) {
  Cities cities = Cities();
  (json['cities'] as List).forEach((element) {
    cities.cities.add(City.fromJson(element));
  });
  return cities;
}
