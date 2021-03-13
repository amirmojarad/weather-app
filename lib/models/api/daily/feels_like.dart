class FeelsLike {
  dynamic day, night, eve, morn, min, max;

  FeelsLike({this.day, this.night, this.eve, this.morn, this.min, this.max});

  factory FeelsLike.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);
}

FeelsLike _$TempFromJson(Map<String, dynamic> json) {
  return FeelsLike(
    day: json["day"],
    morn: json["morn"],
    eve: json["eve"],
    max: json["max"],
    min: json["min"],
    night: json["night"],
  );
}
