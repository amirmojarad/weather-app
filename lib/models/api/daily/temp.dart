class Temp {
  dynamic day, night, eve, morn, min, max;

  Temp({this.day, this.night, this.eve, this.morn, this.min, this.max});

  factory Temp.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);
}

Temp _$TempFromJson(Map<String, dynamic> json) {
  return Temp(
      day: json["day"],
      morn: json["morn"],
      eve: json["eve"],
      max: json["max"],
      min: json["min"],
      night: json["night"]);
}
