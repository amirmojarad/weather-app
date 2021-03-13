import 'package:weather/models/api/daily/day.dart';

class Daily {
  List<Day> days;

  Daily({this.days});

  factory Daily.fromJson(List<dynamic> days) => _$DailyFromJson(days);
}

Daily _$DailyFromJson(List<dynamic> input) {
  List<Day> days = [];
  input.forEach((element) {
    days.add(Day.fromJson(element));
  });
  return Daily(days: days);
}
