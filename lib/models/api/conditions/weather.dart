import 'package:weather/models/json_interfaces/to_json.dart';

class Weather implements ToJson {
  dynamic id;
  dynamic main;
  dynamic description;
  dynamic icon;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Weather({this.id, this.main, this.description, this.icon});

  @override
  Map<String, dynamic> toJson() {
    return {"id": id, "main": main, "description": description, "icon": icon};
  }
}

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    id: json["id"],
    description: json["description"],
    icon: json["icon"],
    main: json["main"],
  );
}
