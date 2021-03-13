import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/api/daily/daily.dart';
import 'package:weather/models/localizations/translate.dart';
import 'package:weather/models/utils/converters/date_converters.dart';

class WeekChart extends StatelessWidget {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  Daily daily;
  List<String> days = [];
  List<FlSpot> spots = [];

  WeekChart({
    Key key,
    this.daily,
  }) : super(key: key) {
    daily.days.forEach((element) {
      days.add(getDay(
          DateTime.fromMillisecondsSinceEpoch(element.dt * 1000).weekday));
    });
    for (int i = 1; i <= 7; i++) {
      spots.add(FlSpot(i.toDouble(), daily.days[i].temp.day));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: false,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return translate(days[value.toInt() - 1], context);
                case 2:
                  return translate(days[value.toInt() - 1], context);
                case 3:
                  return translate(days[value.toInt() - 1], context);
                case 4:
                  return translate(days[value.toInt() - 1], context);
                case 5:
                  return translate(days[value.toInt() - 1], context);
                case 6:
                  return translate(days[value.toInt() - 1], context);
                case 7:
                  return translate(days[value.toInt() - 1], context);
              }
              return '';
            },
            margin: 8,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff67727d),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 10:
                  return '10';
                case 20:
                  return '20';
                case 30:
                  return '30';
                case 40:
                  return '40';
                case 50:
                  return '50';
              }
              return '';
            },
            reservedSize: 28,
            margin: 12,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 1,
        maxX: 7,
        minY: 0,
        maxY: 50,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            colors: gradientColors,
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
            ),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
