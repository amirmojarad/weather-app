class Temp {
  dynamic day, night, eve, morn, min, max;

  Temp({this.day, this.night, this.eve, this.morn, this.min, this.max});

  factory Temp.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);
}

Temp _$TempFromJson(Map<String, dynamic> json) {
  return Temp(
      day: double.parse(json["day"].toString()),
      morn: double.parse(json["morn"].toString()),
      eve: double.parse(json["eve"].toString()),
      max: double.parse(json["max"].toString()),
      min: double.parse(json["min"].toString()),
      night: double.parse(json["night"].toString()));
}
