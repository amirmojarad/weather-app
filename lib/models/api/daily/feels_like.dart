class FeelsLike {
  dynamic day, night, eve, morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  factory FeelsLike.fromJson(Map<String, dynamic> json) =>
      _$FeelsLikeFromJson(json);
}

FeelsLike _$FeelsLikeFromJson(Map<String, dynamic> json) {
  return FeelsLike(
    day: json["day"],
    morn: json["morn"],
    eve: json["eve"],
    night: json["night"],
  );
}
