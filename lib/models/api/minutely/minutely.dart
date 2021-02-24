import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weather/models/api/minutely/data.dart';

class Minutely {
  List<MinutelyData> data;

  factory Minutely.fromJson(List<dynamic> list) => _$MinutelyFromJson(list);

  Minutely(List<dynamic> list) {
    data = List<MinutelyData>();
    list.forEach((element) {
      data.add(MinutelyData.fromJson(element));
    });
  }
}

Minutely _$MinutelyFromJson(List<dynamic> list) {
  return Minutely(list);
}
