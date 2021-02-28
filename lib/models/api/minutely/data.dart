class MinutelyData {
  dynamic dt; //Time of the forecasted data, unix, UTC
  dynamic precipitation;

  MinutelyData({this.dt, this.precipitation});

  factory MinutelyData.fromJson(Map<String, dynamic> json) =>
      _$MinutelyDataFromJson(json);
}

MinutelyData _$MinutelyDataFromJson(Map<String, dynamic> json) {
  return MinutelyData(
    dt: json["dt"],
    precipitation: json["precipitation"],
  );
}
